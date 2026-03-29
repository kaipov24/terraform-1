variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "vpc_id" {
  description = "VPC id"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC cidr"
  type        = string
}

variable "subnet_public_a" {
  description = "subnet-public-a"
  type        = string
}

variable "subnet_public_b" {
  description = "subnet-public-b"
  type        = string
}

variable "subnet_public_c" {
  description = "subnet-public-c"
  type        = string
}

variable "subnet_public_a_cidr" {
  description = "subnet-public-a-cidr"
  type        = string
}

variable "subnet_public_b_cidr" {
  description = "subnet-public-b-cidr"
  type        = string
}

variable "subnet_public_c_cidr" {
  description = "subnet-public-c-cidr"
  type        = string
}

variable "igw" {
  description = "Internet Gateway"
  type        = string
}

variable "az_a" {
  description = "az-a"
  type        = string
}

variable "az_b" {
  description = "az-b"
  type        = string
}

variable "az_c" {
  description = "az-c"
  type        = string
}

variable "routing_table" {
  description = "Routing Table"
  type        = string
}
