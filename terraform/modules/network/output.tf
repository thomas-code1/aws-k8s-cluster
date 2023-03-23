output "subnet_list" {
  description = "List of newly created subnets"
  value       = aws_subnet.cluster_subnet.*.id
}

output "controlplane_sg_id" {
  description = "Security Group ID"
  value       = aws_security_group.controlplane_sg.id
}

output "worker_sg_id" {
  description = "Security Group ID"
  value       = aws_security_group.worker_sg.id
}
