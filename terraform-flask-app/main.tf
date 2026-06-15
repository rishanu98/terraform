module "networking" {
  source              = "./modules/networking"
  vpc_cidr            = var.vpc_cidr
  public_subnets_cidr = var.public_subnets_cidr
  azs                 = var.azs
}

module "security" {
  source   = "./modules/security"
  vpc_id   = module.networking.vpc_id
  vpc_cidr = var.vpc_cidr
}

module "load_balancer" {
  source             = "./modules/load_balancer"
  vpc_id             = module.networking.vpc_id
  alb_security_group = module.security.aws_elb_sg_id
  public_subnet_ids  = module.networking.public_subnet_ids
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name

}

module "keypair" {
  source = "./modules/keypair"
  key_name = var.key_name
  public_key_path = var.public_key_path
}

module "asg" {
  source                = "./modules/asg"
  project_name          = "web_app"
  ec2_security_group_id = module.security.web_server_sg_id
  public_subnet_ids     = module.networking.public_subnet_ids
  ami_id                = var.ami_id
  instance_type         = var.instance_type
  key_name              = var.key_name
  target_group_arns     = module.load_balancer.target_group_arn
}
