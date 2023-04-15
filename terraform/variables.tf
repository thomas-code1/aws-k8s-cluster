variable "worker_number" {
  type        = number
  description = "Number of K8S worker nodes to provision"
  default     = 1
}

variable "aws_region" {
  description = "AWS Region where to provision the K8S cluster"
  type        = string
  default     = "eu-west-2" # London
}

variable "ec2_type" {
  description = "EC2 Type"
  type        = string
  default     = "t3.medium" # 2 vCPU 4Gi  0,0472 USD / h
  #  default     = "t2.medium" # 2 vCPU 4Gi  0,052 USD / h
  #   default     = "c5.xlarge" # 4 vCPU 8Gi  0,202 USD / h
  #   default     = "c5.large" # 4 vCPU 8Gi 0,101 USD / h
  # t2.micro 0,0132 USD/h
}
