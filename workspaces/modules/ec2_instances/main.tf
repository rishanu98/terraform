provider "aws" {
  region = "us-east-1"
}

variable "ami_id" {
  description = "The ID of the AMI to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of the EC2 instance type. for example: t2.micro"
  type        = string
}

resource "aws_instance" "test_instance" {
  ami = var.ami_id
  instance_type = var.instance_type
}