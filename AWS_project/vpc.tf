resource "aws_vpc" "vpc" {
  cidr_block       = var.cidr
  instance_tenancy = "default"
  tags = {
    Name = "vpc"
  }

}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "igw"
  }

}
resource "aws_subnet" "pub1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.cidr_pub1
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "public_subnet1"
  }

}
resource "aws_subnet" "pub2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.cidr_pub2
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "public_subnet2"
  }

}
resource "aws_route_table" "pub1" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public_rt1"
  }

}
resource "aws_route_table" "pub2" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public_rt2"
  }

}
resource "aws_route_table_association" "pub_rt1" {
  subnet_id      = aws_subnet.pub1.id
  route_table_id = aws_route_table.pub1.id

}
resource "aws_route_table_association" "pub_rt2" {
  subnet_id      = aws_subnet.pub2.id
  route_table_id = aws_route_table.pub2.id

}
