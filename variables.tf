variable "aws_region" {
  default = "us-east-1"
}

variable "env" {
  default = "dev"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "ami_id" {}
variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {}
variable "allowed_ip" {}

variable "db_user" {}
variable "db_pass" {}


