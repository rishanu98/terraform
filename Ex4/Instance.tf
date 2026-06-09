resource "aws_instance" "web" {
  ami           = data.aws_ami.amiID.id
  instance_type = "t3.micro"
  key_name      = "deploy-key"

  vpc_security_group_ids = [aws_security_group.terraform-sg.id]
  availability_zone      = var.zone

  provisioner "file" {
  source      = "web.sh"
  destination = "/tmp/web.sh"
  }

  connection {
    type     = "ssh"
    user     = var.user
    private_key = file("~/.ssh/id_rsa")
    host     = self.public_ip
  }


  provisioner "remote-exec" {
  inline = [
    "chmod +x /tmp/web.sh",
    "sudo /tmp/web.sh"
  ]
  }

  tags = {
    Name    = "terraform-ubuntu-server"
    Project = "terraform-ec2"
  }
}