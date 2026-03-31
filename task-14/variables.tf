variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "internet_gateway_name" {
  description = "Internet Gateway name"
  type        = string
}

variable "route_table_name" {
  description = "Route table name"
  type        = string
}

variable "public_subnets" {
  description = "Public subnet definitions"
  type = map(object({
    name              = string
    cidr_block        = string
    availability_zone = string
  }))
}

variable "allowed_ip_range" {
  description = "Allowed IP ranges"
  type        = list(string)
}

variable "ssh_sg_name" {
  description = "SSH security group name"
  type        = string
}

variable "public_http_sg_name" {
  description = "Public HTTP security group name"
  type        = string
}

variable "private_http_sg_name" {
  description = "Private HTTP security group name"
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
  description = "ASG name"
  type        = string
}

variable "desired_capacity" {
  description = "ASG desired capacity"
  type        = number
}

variable "min_size" {
  description = "ASG min size"
  type        = number
}

variable "max_size" {
  description = "ASG max size"
  type        = number
}

variable "lb_name" {
  description = "Load balancer name"
  type        = string
}