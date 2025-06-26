variable "env" {}
variable "db_user" {}
variable "db_pass" {}
variable "rds_sg" {}
variable "subnet_ids" {
  type = list(string)
}

