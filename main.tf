resource "aws_vpc" "vpc" {
    cidr_block = var.cidr
    instance_tenancy = "default"
    provider = aws.us-west-2
    tags = {
        Name = "VPC"
    }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  provider = aws.us-west-2

  tags = {
    Name = "IGW"
  }
}
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.cidr_pub
    provider = aws.us-west-2
    tags = {
        Name = "public_subnet"
    }

  
}
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.cidr_pri
    provider = aws.us-west-2
    tags = {
        Name = "private_subnet"
    }  
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  provider = aws.us-west-2

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "public_RT"
  }
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  provider = aws.us-west-2

  tags = {
    Name = "priavte_RT"
  }
}

resource "aws_route_table_association" "public" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public.id
    provider = aws.us-west-2
  
}
resource "aws_route_table_association" "private" {
    subnet_id = aws_subnet.private.id
    route_table_id = aws_route_table.private.id
    provider = aws.us-west-2
  
}