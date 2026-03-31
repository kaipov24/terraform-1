resource "aws_lb" "main" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.lb.id]
  subnets = [
    data.aws_subnet.public_1.id,
    data.aws_subnet.public_2.id
  ]

  tags = {
    Name = var.lb_name
  }
}

resource "aws_lb_target_group" "blue" {
  name     = var.blue_tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.main.id

  health_check {
    path = "/"
  }

  tags = {
    Name = var.blue_tg_name
  }
}

resource "aws_lb_target_group" "green" {
  name     = var.green_tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.main.id

  health_check {
    path = "/"
  }

  tags = {
    Name = var.green_tg_name
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"

    forward {
      target_group {
        arn    = aws_lb_target_group.blue.arn
        weight = var.blue_weight
      }

      target_group {
        arn    = aws_lb_target_group.green.arn
        weight = var.green_weight
      }
    }
  }

  tags = {
    Name = "${var.lb_name}-listener"
  }
}

resource "aws_launch_template" "blue" {
  name          = var.blue_lt_name
  image_id      = data.aws_ami.amazon_linux_2023.id
  instance_type = "t2.micro"

  vpc_security_group_ids = [
    data.aws_security_group.ssh.id,
    data.aws_security_group.http.id
  ]

  user_data = base64encode(file("${path.module}/start-blue.sh"))

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = var.blue_lt_name
    }
  }

  tags = {
    Name = var.blue_lt_name
  }
}

resource "aws_launch_template" "green" {
  name          = var.green_lt_name
  image_id      = data.aws_ami.amazon_linux_2023.id
  instance_type = "t2.micro"

  vpc_security_group_ids = [
    data.aws_security_group.ssh.id,
    data.aws_security_group.http.id
  ]

  user_data = base64encode(file("${path.module}/start-green.sh"))

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = var.green_lt_name
    }
  }

  tags = {
    Name = var.green_lt_name
  }
}

resource "aws_autoscaling_group" "blue" {
  name             = var.blue_asg_name
  desired_capacity = 2
  min_size         = 2
  max_size         = 2
  vpc_zone_identifier = [
    data.aws_subnet.public_1.id,
    data.aws_subnet.public_2.id
  ]

  target_group_arns = [aws_lb_target_group.blue.arn]

  launch_template {
    id      = aws_launch_template.blue.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = var.blue_asg_name
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "green" {
  name             = var.green_asg_name
  desired_capacity = 2
  min_size         = 2
  max_size         = 2
  vpc_zone_identifier = [
    data.aws_subnet.public_1.id,
    data.aws_subnet.public_2.id
  ]

  target_group_arns = [aws_lb_target_group.green.arn]

  launch_template {
    id      = aws_launch_template.green.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = var.green_asg_name
    propagate_at_launch = true
  }
}