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


# Creates the controlplane node
module "controlplane" {
  source = "./modules/ec2" # use path.module

  node_ami  = data.aws_ami.ubuntu_ami.image_id
  node_size = var.ec2_type

  # creates the controlplane on the 1st newly created subnet
  node_subnet = module.network.subnet_list[0]

  associate_public_ip = true
  node_name           = "K8S Controlplane"
  node_sg_id          = module.network.k8s_sg_id
  aws_key             = module.network.ssh_key
}

# Creates the worker nodes
module "worker" {
  count  = var.worker_number
  source = "./modules/ec2" # use path.module

  node_ami  = data.aws_ami.ubuntu_ami.image_id
  node_size = var.ec2_type

  # creates the nodes on the different newly created subnets
  node_subnet = element(module.network.subnet_list, count.index % length(module.network.subnet_list))

  associate_public_ip = true
  node_name           = "K8S Worker ${count.index + 1}"
  node_sg_id          = module.network.k8s_sg_id
  aws_key             = module.network.ssh_key
}

# Creation of Ansible inventory file
resource "local_file" "ansible_inventory" {
  content = templatefile("./modules/templates/hosts.tpl",
    {
      controlplane_ip = module.controlplane.public_ip
      worker_ip       = module.worker.*.public_ip
    }
  )
  filename = "../ansible/hosts"
}
