# Retrieves the AZ of the region
data "aws_availability_zones" "available" {
  state = "available"
}

# Creates the Subnets
resource "aws_subnet" "cluster_subnet" {
  count      = length(data.aws_availability_zones.available.names)
  vpc_id     = aws_vpc.cluster_vpc.id
  cidr_block = "10.0.${count.index}.0/24"

  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "K8S Cluster subnet ${count.index + 1}"
  }
}