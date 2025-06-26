resource "aws_db_instance" "db" {
  identifier             = "${var.env}-bookstore-db"
  engine                 = "mysql"
  instance_class         = "db.t3.micro"
  username               = var.db_user
  password               = var.db_pass
  allocated_storage      = 20
  vpc_security_group_ids = [var.rds_sg]
  skip_final_snapshot    = true
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name   # ✅ ADD THIS

  tags = {
    Name        = "${var.env}-rds"
    Environment = var.env
    Project     = "online-bookstore"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.env}-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.env}-db-subnet-group"
  }
}

