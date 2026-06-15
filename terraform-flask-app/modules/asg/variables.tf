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

variable "web_server_sg_id" {
  description = "ID of the security group for the web servers"
  type = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the EC2 instances"
  type        = list(string)
}