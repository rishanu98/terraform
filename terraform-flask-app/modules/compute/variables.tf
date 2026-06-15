variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type = string
}

variable "public_key_path" {
  description = "Path to the public key file for the SSH key pair"
  type = string
}

variable "ec2_security_group_id" {
  description = "ID of the EC2 security group"
  type = string
}

variable "user_data_file_path" {
  description = "Path to the user data file"
  type = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the EC2 instances"
  type        = list(string)
}