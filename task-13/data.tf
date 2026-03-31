data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "public_1" {
  filter {
    name   = "tag:Name"
    values = [var.public_subnet_1_name]
  }
}

data "aws_subnet" "public_2" {
  filter {
    name   = "tag:Name"
    values = [var.public_subnet_2_name]
  }
}

data "aws_security_group" "ssh" {
  filter {
    name   = "tag:Name"
    values = [var.sg_ssh_name]
  }
}

data "aws_security_group" "http" {
  filter {
    name   = "tag:Name"
    values = [var.sg_http_name]
  }
}

data "aws_security_group" "lb" {
  filter {
    name   = "tag:Name"
    values = [var.sg_lb_name]
  }
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}