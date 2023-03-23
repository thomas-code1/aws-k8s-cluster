output "controlplane_ip" {
  value = join(", ", module.controlplane.*.public_ip, module.controlplane.*.private_ip)
}

output "worker_ip" {
  value = join(", ", module.worker.*.public_ip, module.worker.*.private_ip)
}

output "ami" {
  value = "AMI selected: ${data.aws_ami.ubuntu_ami.image_id}"
}

