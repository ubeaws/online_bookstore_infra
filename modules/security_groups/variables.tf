variable "env" {}
variable "vpc_id" {}
variable "allowed_ip" {}
variable "ec2_subnet_cidrs" {
  type = list(string)
}

