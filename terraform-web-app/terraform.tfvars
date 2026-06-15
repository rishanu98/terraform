vpc_cidr = "10.0.0.0/16"

public_subnets_cidr = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

azs = [
  "us-east-1a",
  "us-east-1b"
]

ami_id = "ami-0b6d9d3d33ba97d99"

instance_type = "t2.micro"

public_key_path = "~/.ssh/id_rsa.pub"

bucket_name = "terraform-statefile0312"

key_name = "web-app-key"