output "web_server_sg_id" {
  value = aws_security_group.web_server_sg.id
}

output "aws_elb_sg_id" {
  value = aws_security_group.aws_elb_sg.id
}