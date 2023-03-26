variable "node_ami" {
  description = "EC2 AMI for K8S nodes"
  type        = string
}

variable "node_size" {
  description = "EC2 type for K8S nodes"
  type        = string
}

variable "node_subnet" {
  description = "Subnet of the K8S nodes"
  type        = string
}

variable "node_sg_id" {
  description = "SG of K8S cluster"
  type        = string
}

variable "node_name" {
  description = "Node Name"
  type        = string
}

variable "aws_key" {
  description = "AWS SSH Key"
  type        = string
}

variable "associate_public_ip" {
  description = "Associate a public IP to the machine"
  type        = bool
}
