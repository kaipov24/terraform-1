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
  description = "Name of the security group that allows SSH access"
  type        = string
}

variable "http_security_group_name" {
  description = "Name of the security group that allows HTTP access to EC2 instances"
  type        = string
}

variable "alb_security_group_name" {
  description = "Name of the security group attached to the Application Load Balancer"
  type        = string
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
  description = "Whether the metadata endpoint is enabled (enabled/disabled)"
  type        = string
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
}

variable "asg_desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
}

variable "asg_min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
}

variable "asg_max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
}

variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "alb_listener_port" {
  description = "Port used by the ALB listener"
  type        = number
}

variable "alb_listener_protocol" {
  description = "Protocol used by the ALB listener (HTTP/HTTPS)"
  type        = string
}

variable "project_tag" {
  description = "Project tag value applied to all resources"
  type        = string
}

variable "terraform_tag" {
  description = "Terraform tag value applied to all resources"
  type        = string
}

variable "ami_id" {
  description = "AMI ID used to launch EC2 instances"
  type        = string
}

variable "metadata_http_tokens" {
  description = "Metadata service token requirement (optional/required)"
  type        = string
}

variable "vpc_id" {
  description = "Name tag of the VPC where resources will be deployed"
  type        = string
}

variable "public_subnet_cidr_a" {
  description = "CIDR block for public subnet A"
  type        = string
}

variable "private_subnet_cidr_a" {
  description = "CIDR block for private subnet A"
  type        = string
}

variable "public_subnet_cidr_b" {
  description = "CIDR block for public subnet B"
  type        = string
}

variable "private_subnet_cidr_b" {
  description = "CIDR block for private subnet B"
  type        = string
}