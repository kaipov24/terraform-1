variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "allowed_ip_range" {
  description = "List of CIDR blocks allowed to access resources"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the existing VPC"
  type        = string
}

variable "public_instance_id" {
  description = "ID of the public EC2 instance"
  type        = string
}

variable "private_instance_id" {
  description = "ID of the private EC2 instance"
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the public subnet"
  type        = string
}

variable "private_subnet_id" {
  description = "ID of the private subnet"
  type        = string
}

variable "project_id" {
  description = "Project identifier used for tagging"
  type        = string
}

variable "public_eni_id" {
  description = "Public instance ENI"
  type        = string
}