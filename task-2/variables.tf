variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "ssh_key" {
  description = "Provides custom public SSH key."
  type        = string
}