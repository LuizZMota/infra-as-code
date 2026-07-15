resource "aws_instance" "website-server" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t3.micro"
  key_name               = "chave-site-prod"
  vpc_security_group_ids = [aws_security_group.website-sg.id]
  iam_instance_profile   = "ecr-ec2-role"

  tags = {
    Name        = "website-server"
    Provisioned = "Terraform"
    Client      = "Luiz Alberto Silva Mota"
  }
}

# Security Group
resource "aws_security_group" "website-sg" {
  name        = "website-sg"
  description = "Security group for website server"
  vpc_id      = "vpc-0c4879bda1ea6d44a"

  tags = {
    Name        = "website-sg"
    Provisioned = "Terraform"
    Client      = "Luiz Alberto Silva Mota"
  }
}

# SSH
resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  security_group_id = aws_security_group.website-sg.id

  protocol    = "tcp"
  from_port   = 22
  to_port     = 22
  cidr_blocks = ["187.102.159.206/32"]
}

# HTTP
resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  security_group_id = aws_security_group.website-sg.id

  protocol    = "tcp"
  from_port   = 80
  to_port     = 80
  cidr_blocks = ["0.0.0.0/0"]
}

# HTTPS
resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  security_group_id = aws_security_group.website-sg.id

  protocol    = "tcp"
  from_port   = 443
  to_port     = 443
  cidr_blocks = ["0.0.0.0/0"]
}

# Saída para qualquer destino
resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.website-sg.id
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  to_port = 0
  from_port = 0
}