# Retrieves the Availability Zone of the Region used
data "aws_availability_zones" "available" {
  state = "available"
}

# Creates one subnet on each Availability Zone 
resource "aws_subnet" "cluster_subnet" {
  count      = length(data.aws_availability_zones.available.names)
  vpc_id     = aws_vpc.cluster_vpc.id
  cidr_block = "10.0.${count.index}.0/24"

  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "K8S Cluster subnet ${count.index + 1}"
  }
}


# Creation of Route 53 zone

resource "aws_route53_zone" "nfs" {
  name = "cluster"
  vpc {
    vpc_id = aws_vpc.cluster_vpc.id
  }

  tags = {
    Name = "NFS"
  }
}


# Creation of A record

resource "aws_route53_record" "nfs" {
  zone_id = aws_route53_zone.nfs.zone_id
  name    = "nfs"
  type    = "A"
  ttl     = "300"
  records = [var.nfs_private_ip]
}
