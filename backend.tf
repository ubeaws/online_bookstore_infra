terraform {
  backend "s3" {
    bucket         = "online-bookstore-tf-state"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "online-bookstore-tf-locks"
    encrypt        = true
  }
}

