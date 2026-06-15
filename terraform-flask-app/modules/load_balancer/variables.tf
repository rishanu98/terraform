variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "alb_security_group" {
  description = "ID of the ALB security group"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}

variable "instance_ids" {
  description = "List of instance IDs to attach to the target group"
  type        = list(string)
}