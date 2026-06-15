output "instance_ids" {
  value = aws_instance.web_server[*].id
}

output "public_ips" {
  value = {
    for key, instance in aws_instance.web_server :
    key => instance.public_ip
  }
}