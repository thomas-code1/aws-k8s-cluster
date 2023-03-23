resource "aws_instance" "node" {
  ami           = var.node_ami
  instance_type = var.node_size
  subnet_id     = var.node_subnet
  key_name      = var.aws_key

  associate_public_ip_address = var.associate_public_ip
  vpc_security_group_ids      = [var.node_sg_id]

  tags = {
    Name = var.node_name
  }
}
