variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "allowed_ip_range" {
  description = "List of CIDR blocks allowed to access resources"
  type        = list(string)
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "internet_gateway_name" {
  description = "Name of the Internet Gateway"
  type        = string
}

variable "route_table_name" {
  description = "Name of the public route table"
  type        = string
}

variable "public_subnets" {
  description = "Map of public subnets"
  type = map(object({
    name              = string
    cidr_block        = string
    availability_zone = string
  }))
}