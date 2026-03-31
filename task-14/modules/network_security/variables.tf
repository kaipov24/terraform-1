variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "allowed_ip_range" {
  description = "Allowed IP ranges for SSH and public HTTP"
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