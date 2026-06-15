provider "aws" {
  region = "us-east-1"
}

variable "ami" {
  description = "The ID of the AMI to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of the EC2 instance type. for example: t2.micro"
  type        = map(string)
  default     = {
    dev  = "t2.micro"
    stage = "t2.small"
    prod = "t2.medium"
  }
}

module "ec2_instance" {
  source = "./modules/ec2_instances"
  ami_id = var.ami
  instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
}