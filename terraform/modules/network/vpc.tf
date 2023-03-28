# Creates a new VPC
resource "aws_vpc" "cluster_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "K8S Cluster VPC"
  }
}

# Creates the Internet Gateway for the new VPC
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.cluster_vpc.id

  tags = {
    Name = "Main IGW"
  }
}

# Adds the internet route to the main RT
resource "aws_default_route_table" "public_rt" {
  default_route_table_id = aws_vpc.cluster_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0" # reaches everywhere through the IGW
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "Main RT"
  }
}
