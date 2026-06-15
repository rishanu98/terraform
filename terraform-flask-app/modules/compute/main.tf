resource "aws_key_pair" "web_app_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "web_server" {
  count = length(var.public_subnet_ids)
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_ids[count.index]   
  key_name                    = aws_key_pair.web_app_key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.ec2_security_group_id]

  user_data = file(var.user_data_file_path)

  tags = {
    Name = "app-${count.index}"
  }
}