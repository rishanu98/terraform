resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = var.bucket_name
  force_destroy = true


  tags = {
    Name = "TerraformStateBucket"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}