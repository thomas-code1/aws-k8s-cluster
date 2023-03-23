data "aws_ami" "ubuntu_ami" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# 
module "network" {
  source = "./modules/network"
}

module "controlplane" {
  source = "./modules/ec2"

  node_ami            = data.aws_ami.ubuntu_ami.image_id
  node_size           = var.ec2_type
  node_subnet         = module.network.subnet_list[0]
  associate_public_ip = true
  #  associate_public_ip = (count.index == 1 ? true : false) # Gives a public IP address only to the 1st machine
  node_name  = "K8S Controlplane"
  node_sg_id = module.network.controlplane_sg_id
}

module "worker" {
  count  = var.worker_number
  source = "./modules/ec2"

  node_ami            = data.aws_ami.ubuntu_ami.image_id
  node_size           = var.ec2_type
  node_subnet         = element(module.network.subnet_list, count.index % length(module.network.subnet_list))
  associate_public_ip = true
  #  associate_public_ip = (count.index == 1 ? true : false) # Gives a public IP address only to the 1st machine
  node_name  = "K8S Worker ${count.index + 1}"
  node_sg_id = module.network.worker_sg_id
}

# resource "local_file" "inventory" {
#   filename = "../ansible/hosts"
#   content  = <<EOF
#   [controlplane]
#   node01 ansible_ssh_host=${module.node[0].public_ip}

#   [workers]
#   node02 ansible_ssh_host=${module.node[1].public_ip}
#   node03 ansible_ssh_host=${module.node[2].public_ip}

#   [nodes:children]
#   controlplane
#   workers

#   [nodes:vars]
#   ansible_ssh_port=22
#   ansible_ssh_user=ubuntu
#   ansible_ssh_common_args='-o StrictHostKeyChecking=accept-new'
#   ansible_ssh_private_key_file="~/.ssh/thomas_perso.pem"

#   [controlplane:vars]
#   kubernetes_role=control_plane

#   [workers:vars]
#   kubernetes_role=node

#   EOF
# }

resource "local_file" "ansible_inventory" {
  content = templatefile("./modules/templates/hosts.tpl",
    {
      controlplane_ip = module.controlplane.public_ip
      worker_ip       = module.worker.*.public_ip
    }
  )
  filename = "../ansible/hosts"
}
