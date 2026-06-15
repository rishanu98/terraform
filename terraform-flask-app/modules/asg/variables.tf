variable "ami_id" {
  type = string
}
variable "instance_type" {
  type = string
}

variable "project_name" {
  type = string
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type = string
}

variable "ec2_security_group_id" {
  description = "ID of the security group for EC2 instances"
  type = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the EC2 instances"
  type        = list(string)
}

variable "target_group_arns" {
    description = "value of target arns"
    type = string
}