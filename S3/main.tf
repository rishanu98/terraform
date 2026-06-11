provider "aws" {
    region = "us-east-1"
}

module "ec2_instance" {
  source = "../EC2/modules/ec2_instance"
  ami_id = "ami-091138d0f0d41ff90"
  instance_type = "t2.micro"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "state-files-bucket-1106"

  tags = {
    Name        = "StateFilesBucket"
    Environment = "Dev"
  }
}

resource "aws_dynamodb_table" "dynamodb-terraform-lock" {
   name = "terraform-lock"
   hash_key = "LockID"
   read_capacity = 20
   write_capacity = 20

   attribute {
      name = "LockID"
      type = "S"
   }

   tags = {
     Name = "Terraform Lock Table"
   }
}