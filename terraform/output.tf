output "node_public_ip" {
  value = join(", ", module.controlplane.*.public_ip)
}

output "node_private_ip" {
  value = join(", ", module.controlplane.*.private_ip)
}

output "ami" {
  value = "AMI selected: ${data.aws_ami.ubuntu_ami.image_id}"
}

