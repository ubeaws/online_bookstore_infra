output "ec2_instance_id" {
  value = module.ec2.ec2_instance_id
}

output "alb_dns" {
  value = module.alb.alb_dns
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "s3_bucket" {
  value = module.s3.bucket_name
}

