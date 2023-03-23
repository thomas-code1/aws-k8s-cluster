variable "worker_number" {
  type        = number
  description = "Number of K8S worker nodes to provision"
  default     = 3
}

variable "aws_region" {
  description = "AWS Region where to provision the K8S cluster"
  type        = string
  default     = "eu-west-2"
}

variable "ec2_type" {
  description = "EC2 Type"
  type        = string
  default     = "c5.xlarge" # 4 vCPU 8Gi
  #  default     = "t3.small"
}
