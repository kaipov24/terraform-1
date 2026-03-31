variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}
variable "subnet_ids" {
  description = "List of subnet IDs for ASG and Load Balancer"
  type        = list(string)
}

variable "ssh_sg_id" {
  description = "SSH security group ID"
  type        = string
}

variable "private_http_sg_id" {
  description = "Private HTTP security group ID"
  type        = string
}

variable "public_http_sg_id" {
  description = "Public HTTP security group ID"
  type        = string
}

variable "launch_template_name" {
  description = "Launch template name"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "asg_name" {
  description = "Auto Scaling Group name"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of instances"
  type        = number
}

variable "min_size" {
  description = "Minimum number of instances"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances"
  type        = number
}

variable "lb_name" {
  description = "Load balancer name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}