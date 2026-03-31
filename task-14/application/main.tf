data "aws_ami" "amazon_linux" {
  description = "Fetch latest Amazon Linux 2023 AMI"
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_launch_template" "this" {
  description   = "Launch template for application instances"
  name_prefix   = var.launch_template_name
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  vpc_security_group_ids = [
    var.ssh_sg_id,
    var.private_http_sg_id
  ]

  user_data = base64encode(<<-EOF
#!/bin/bash
yum update -y
yum install -y httpd

systemctl enable httpd
systemctl start httpd

COMPUTE_MACHINE_UUID=$(cat /sys/devices/virtual/dmi/id/product_uuid | tr '[:upper:]' '[:lower:]')
COMPUTE_INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

echo "This message was generated on instance $${COMPUTE_INSTANCE_ID} with the following UUID $${COMPUTE_MACHINE_UUID}" > /var/www/html/index.html
EOF
  )

  network_interfaces {
    description             = "Network interface configuration"
    delete_on_termination   = true
  }
}

resource "aws_lb" "this" {
  name               = var.lb_name
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = [var.public_http_sg_id]
}

resource "aws_lb_target_group" "this" {
  name        = "${var.lb_name}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_autoscaling_group" "this" {
  name             = var.asg_name
  desired_capacity = var.desired_capacity
  min_size         = var.min_size
  max_size         = var.max_size

  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [
      load_balancers,
      target_group_arns
    ]
  }
}

resource "aws_autoscaling_attachment" "this" {
  autoscaling_group_name = aws_autoscaling_group.this.name
  lb_target_group_arn    = aws_lb_target_group.this.arn
}