variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "project_prefix" {
  description = "Project prefix for naming"
  type        = string
}

variable "lb_name" {
  description = "Application Load Balancer name"
  type        = string
}

variable "blue_tg_name" {
  description = "Blue target group name"
  type        = string
}

variable "green_tg_name" {
  description = "Green target group name"
  type        = string
}

variable "blue_asg_name" {
  description = "Blue Auto Scaling Group name"
  type        = string
}

variable "green_asg_name" {
  description = "Green Auto Scaling Group name"
  type        = string
}

variable "blue_lt_name" {
  description = "Blue Launch Template name"
  type        = string
}

variable "green_lt_name" {
  description = "Green Launch Template name"
  type        = string
}

variable "sg_ssh_name" {
  description = "SSH security group name"
  type        = string
}

variable "sg_http_name" {
  description = "HTTP security group name"
  type        = string
}

variable "sg_lb_name" {
  description = "ALB security group name"
  type        = string
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "public_subnet_1_name" {
  description = "Public subnet 1 name"
  type        = string
}

variable "public_subnet_2_name" {
  description = "Public subnet 2 name"
  type        = string
}

variable "blue_weight" {
  description = "The traffic weight for the Blue Target Group"
  type        = number
  default     = 100
}

variable "green_weight" {
  description = "The traffic weight for the Green Target Group"
  type        = number
  default     = 0
}