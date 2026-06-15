resource "aws_launch_template" "web_server_lt" {
  name_prefix   = "web-server-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.web_server_sg_id]
    subnet_id                   = element(var.public_subnet_ids, count.index % length(var.public_subnet_ids))
  }

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "web-server-lt"
    }
  }
}