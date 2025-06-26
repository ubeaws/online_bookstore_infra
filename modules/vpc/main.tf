resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name        = "${var.env}-vpc"
    Environment = var.env
    Project     = "online-bookstore"
  }
}

resource "aws_subnet" "public" {
  count             = length(var.public_subnets)
  cidr_block        = element(var.public_subnets, count.index)
  vpc_id            = aws_vpc.main.id
  availability_zone = element(var.azs, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.env}-public-subnet-${count.index}"
    Environment = var.env
    Project     = "online-bookstore"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.env}-igw"
  }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.env}-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

