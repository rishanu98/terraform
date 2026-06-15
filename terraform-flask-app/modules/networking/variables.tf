variable "vpc_cidr" {
  description = "value of cidr for vpc"
  type        = string
}

variable "public_subnets_cidr" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}