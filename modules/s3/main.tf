resource "aws_s3_bucket" "static_assets" {
  bucket        = "${var.env}-bookstore-assets"
  force_destroy = true

  tags = {
    Name        = "${var.env}-bookstore-assets"
    Environment = var.env
    Project     = "online-bookstore"
  }
}

