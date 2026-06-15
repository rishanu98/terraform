output "alb_dns_name" {
  value = module.load_balancer.alb_dns_name
}

output "instance_public_ips" {
  value = module.compute.public_ips
}