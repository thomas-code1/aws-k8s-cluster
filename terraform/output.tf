output "controlplane_ip" {
  value = module.controlplane.public_ip
}

output "worker_ip" {
  value = join(", ", module.worker.*.public_ip)
}

output "ami" {
  value = "AMI selected: ${data.aws_ami.ubuntu_ami.image_id}"
}
