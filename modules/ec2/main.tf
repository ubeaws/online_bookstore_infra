resource "aws_instance" "app_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_id]
  key_name                    = var.key_name

  tags = {
    Name        = "${var.env}-app-server"
    Environment = var.env
    Project     = "online-bookstore"
  }
}

