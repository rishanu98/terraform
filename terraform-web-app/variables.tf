variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  type = list(string)
}
variable "bucket_name" {
  description = "Name of the S3 bucket for Terraform state storage"
  type        = string
}

variable "azs" {
  type = list(string)
}

variable "ami_id" {
  default = "ami-0b6d9d3d33ba97d99"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "web-app-key"
}

variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "ssh_my_ip" {
  default = "141.72.242.43/32"
}

variable "app_port" {
  default = 5000
}

variable "target_ids" {
  type    = list(string)
  default = []
}