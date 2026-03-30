data "aws_security_group" "ec2" {
  filter {
    name   = "group-name"
    values = [var.ec2_security_group_name]
  }
}

data "aws_security_group" "http" {
  filter {
    name   = "group-name"
    values = [var.http_security_group_name]
  }
}

resource "aws_launch_template" "example" {
  name = var.launch_template_name

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  image_id = var.ami_id

  instance_type = var.instance_type

  key_name = var.ssh_key_name

  metadata_options {
    http_endpoint = var.metadata_http_endpoint
    http_tokens   = var.metadata_http_tokens
  }

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true

    security_groups = [
      data.aws_security_group.ec2.id,
      data.aws_security_group.http.id
    ]
  }


  tag_specifications {
    resource_type = "instance"

    tags = {
      Terraform = var.terraform_tag
      Project   = var.project_tag
    }
  }

  tags = {
    Terraform = var.terraform_tag
    Project   = var.project_tag
  }

  user_data = base64encode(<<-EOF
#!/bin/bash
yum update -y
yum install -y httpd jq

systemctl enable httpd
systemctl start httpd

TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $${TOKEN}" http://169.254.169.254/latest/meta-data/instance-id)
IP_ADDRESS=$(curl -s -H "X-aws-ec2-metadata-token: $${TOKEN}" http://169.254.169.254/latest/meta-data/local-ipv4)

MESSAGE="This message was generated on instance $${INSTANCE_ID} with the following IP: $${IP_ADDRESS}"
echo "$${MESSAGE}" > /var/www/html/index.html
EOF
  )
}

data "aws_subnets" "public" {
  filter {
    name   = "cidr-block"
    values = [var.public_subnet_cidr_a, var.public_subnet_cidr_b]
  }
}

resource "aws_autoscaling_group" "bar" {
  name             = var.asg_name
  desired_capacity = var.asg_desired_capacity
  max_size         = var.asg_max_size
  min_size         = var.asg_min_size

  vpc_zone_identifier = data.aws_subnets.public.ids

  lifecycle {
    ignore_changes = [
      load_balancers,
      target_group_arns
    ]
  }

  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }

  tag {
    key                 = "Terraform"
    value               = var.terraform_tag
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.project_tag
    propagate_at_launch = true
  }
}

data "aws_security_group" "alb" {
  filter {
    name   = "group-name"
    values = [var.alb_security_group_name]
  }
}

resource "aws_lb" "test" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.alb.id]
  subnets            = data.aws_subnets.public.ids

  enable_deletion_protection = true

  tags = {
    Terraform = var.terraform_tag
    Project   = var.project_tag
  }
}

data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_id]
  }
}

resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.main.id

  tags = {
    Terraform = var.terraform_tag
    Project   = var.project_tag
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.test.arn
  port              = var.alb_listener_port
  protocol          = var.alb_listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }

  tags = {
    Terraform = var.terraform_tag
    Project   = var.project_tag
  }
}

resource "aws_autoscaling_attachment" "example" {
  autoscaling_group_name = aws_autoscaling_group.bar.name
  lb_target_group_arn    = aws_lb_target_group.test.arn
}