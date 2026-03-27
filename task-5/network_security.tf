resource "aws_security_group" "allow_ssh" {
  name        = "${var.project_id}-ssh-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  ingress {
    description = "ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.allowed_ip_range
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_id}-ssh-sg"
    Project = var.project_id
  }
}

resource "aws_security_group" "public_http" {
  name   = "${var.project_id}-public-http-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  ingress {
    description = "ICMP access"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.allowed_ip_range
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_id}-public-http-sg"
    Project = var.project_id
  }
}

resource "aws_security_group" "private_http" {
  name        = "${var.project_id}-private-http-sg"
  description = "Private http inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP from public SG"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.public_http.id]
  }

  ingress {
    description     = "ICMP from public SG"
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    security_groups = [aws_security_group.public_http.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_id}-private-http-sg"
    Project = var.project_id
  }
}

data "aws_network_interface" "public" {
  filter {
    name   = "attachment.instance-id"
    values = [var.public_instance_id]
  }
}

data "aws_network_interface" "private" {
  filter {
    name   = "attachment.instance-id"
    values = [var.private_instance_id]
  }
}

resource "aws_network_interface_sg_attachment" "public_ssh" {
  security_group_id    = aws_security_group.allow_ssh.id
  network_interface_id = data.aws_network_interface.public.id
}

resource "aws_network_interface_sg_attachment" "public_http" {
  security_group_id    = aws_security_group.public_http.id
  network_interface_id = var.public_eni_id
}

resource "aws_network_interface_sg_attachment" "private_ssh" {
  security_group_id    = aws_security_group.allow_ssh.id
  network_interface_id = data.aws_network_interface.private.id
}

resource "aws_network_interface_sg_attachment" "private_http" {
  security_group_id    = aws_security_group.private_http.id
  network_interface_id = data.aws_network_interface.private.id
}