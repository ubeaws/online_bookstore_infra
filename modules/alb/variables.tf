variable "env" {}
variable "alb_sg" {}
variable "vpc_id" {}   # Required for target group
variable "public_subnet_ids"{
  type = list(string)
}
