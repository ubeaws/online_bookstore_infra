provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source         = "./modules/vpc"
  cidr_block     = var.cidr_block
  public_subnets = var.public_subnets
  azs            = var.azs
  env            = var.env
}

module "security_groups" {
  source            = "./modules/security_groups"
  env               = var.env
  vpc_id            = module.vpc.vpc_id
  allowed_ip        = var.allowed_ip
  ec2_subnet_cidrs  = module.vpc.public_subnet_cidrs
}

module "s3" {
  source = "./modules/s3"
  env    = var.env
}

module "ec2" {
  source        = "./modules/ec2"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnet_ids[0]
  key_name      = var.key_name
  sg_id         = module.security_groups.ec2_sg_id
  env           = var.env
}

module "alb" {
  source            = "./modules/alb"
  env               = var.env
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg            = module.security_groups.alb_sg_id
  vpc_id            = module.vpc.vpc_id
}
module "rds" {
  source       = "./modules/rds"
  env          = var.env
  db_user      = var.db_user
  db_pass      = var.db_pass
  subnet_ids   = module.vpc.public_subnet_ids   # ✅ Auto subnet group creation
  rds_sg       = module.security_groups.rds_sg_id
}
module "cloudwatch" {
  source      = "./modules/cloudwatch"
  env         = var.env
  instance_id = module.ec2.ec2_instance_id
}
module "autoscaling" {
  source            = "./modules/autoscaling"
  env               = var.env
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  public_subnet_ids = module.vpc.public_subnet_ids
  ec2_sg            = module.security_groups.ec2_sg_id
  target_group_arn  = module.alb.target_group_arn
}
module "monitoring" {
  source     = "./modules/monitoring"
  env        = var.env
  asg_name   = module.autoscaling.asg_name
  scale_out_policy_arn = module.autoscaling.scale_out_policy_arn
  scale_in_policy_arn  = module.autoscaling.scale_in_policy_arn
}

