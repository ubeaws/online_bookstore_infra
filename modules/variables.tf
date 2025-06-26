variable "env" {}
variable "vpc_id" {}
variable "allowed_ip" {}               # Your IP, e.g., "12.34.56.78/32"
variable "ec2_subnet_cidrs" {          # e.g., ["10.0.1.0/24", "10.0.2.0/24"]
  type = list(string)
}

