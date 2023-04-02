output "subnet_list" {
  description = "List of newly created subnets"
  value       = aws_subnet.cluster_subnet.*.id
}

output "k8s_sg_id" {
  description = "K8S Security Group ID"
  value       = aws_security_group.k8s_sg.id
}

output "ssh_key" {
  description = "SSH key pair"
  value       = aws_key_pair.k8s_key.key_name
}
