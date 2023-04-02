# Creation of SSH Key

resource "aws_key_pair" "k8s_key" {
  key_name   = "K8S SSH key"
  public_key = file("~/.ssh/thomas_perso.pub")
}

# Creation of K8S Security Groups

# Controlplane Security Group
resource "aws_security_group" "k8s_sg" {
  name        = "K8S SG"
  description = "K8S Security Group"
  vpc_id      = aws_vpc.cluster_vpc.id

  tags = {
    Name = "K8S SG"
  }
}

# DECLARATION OF SECURITY RULES

# SSH Port Rule

resource "aws_security_group_rule" "ssh" {
  security_group_id = aws_security_group.k8s_sg.id

  description = "SSH"
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "html" {
  security_group_id = aws_security_group.k8s_sg.id

  description = "HTML"
  type        = "ingress"
  from_port   = 30007
  to_port     = 30007
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

# Outbound Traffic Port Rule

resource "aws_security_group_rule" "all_outbound" {
  security_group_id = aws_security_group.k8s_sg.id

  description = "All outbound"
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

# All traffic in the SG

resource "aws_security_group_rule" "k8s_controlplane_rules_1" {
  security_group_id = aws_security_group.k8s_sg.id

  description              = "All traffic"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.k8s_sg.id
}
