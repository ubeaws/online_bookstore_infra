variable "env" {}
variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "public_subnet_ids" {
  type = list(string)
}
variable "ec2_sg" {}
variable "target_group_arn" {}

