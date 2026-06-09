resource "aws_instance" "web" {
  ami           = data.aws_ami.amiID.id
  instance_type = "t3.micro"
  key_name      = "deploy-key"

  vpc_security_group_ids = [aws_security_group.terraform-sg.id]
  availability_zone      = var.zone

  tags = {
    Name    = "terraform-ubuntu-server"
    Project = "terraform-ec2"
  }
}

resource "aws_ec2_instance_state" "web-state" {
  instance_id = aws_instance.web.id
  state       = "stopped"
}