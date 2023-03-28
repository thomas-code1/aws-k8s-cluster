output "subnet_list" {
  description = "List of newly created subnets"
  value       = aws_subnet.cluster_subnet.*.id
}

output "controlplane_sg_id" {
  description = "Controlplane Security Group ID"
  value       = aws_security_group.controlplane_sg.id
}

output "worker_sg_id" {
  description = "Workers Security Group ID"
  value       = aws_security_group.worker_sg.id
}

output "ssh_key" {
  description = "SSH key pair"
  value       = aws_key_pair.k8s_key.key_name
}
