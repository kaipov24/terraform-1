variable "aws_region" {
  description = "AWS region where resources will be created"
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
  description = "List of IP ranges for secure access (required by task)"
  type        = list(string)
}