variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "project_id" {
  description = "Project identifier for tagging"
  type        = string
}

variable "state_bucket" {
  description = "S3 bucket name for remote state"
  type        = string
}

variable "state_key" {
  description = "S3 key path for remote state file"
  type        = string
}