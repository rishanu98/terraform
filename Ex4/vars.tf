variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "zone" {
  description = "Availability zone"
  type        = string
  default     = "us-east-1a"
}

variable "user" {
  description = "User for SSH connection"
  default     = "ubuntu"
}