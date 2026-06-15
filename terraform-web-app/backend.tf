terraform {
  backend "s3" {
    bucket = "terraform-statefile0312"
    key    = "backend/terraform_state.tfstate"
    region = "us-east-1"
    use_lockfile = true
    encrypt = true
  }
}