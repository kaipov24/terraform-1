variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "launch_template_name" {
  description = "Name of the EC2 launch template"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for launch template"
  type        = string
}

variable "ec2_security_group_name" {
  description = "AWS Security Group"
  type        = string
}

variable "http_security_group_name" {
  type = string
}

variable "alb_security_group_name" {
  type = string
}

variable "ssh_key_name" {
  description = "SSH key pair name for EC2 instances"
  type        = string
}

variable "iam_instance_profile_name" {
  description = "IAM instance profile name for EC2 instances"
  type        = string
}

variable "metadata_http_endpoint" {
  description = "Whether the metadata endpoint is enabled"
  type        = string
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
}

variable "asg_desired_capacity" {
  description = "Desired number of instances in ASG"
  type        = number
}

variable "asg_min_size" {
  description = "Minimum number of instances in ASG"
  type        = number
}

variable "asg_max_size" {
  description = "Maximum number of instances in ASG"
  type        = number
}

variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "alb_listener_port" {
  description = "Listener port for ALB"
  type        = number
}

variable "alb_listener_protocol" {
  description = "Listener protocol for ALB"
  type        = string
}

variable "project_tag" {
  description = "Project tag value"
  type        = string
}

variable "terraform_tag" {
  description = "Terraform tag value"
  type        = string
}

variable "ami_id" {
  type = string
}

variable "metadata_http_tokens" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_cidr_a" {
  type = string
}

variable "private_subnet_cidr_a" {
  type = string
}

variable "public_subnet_cidr_b" {
  type = string
}

variable "private_subnet_cidr_b" {
  type = string
}
