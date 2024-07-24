resource "aws_vpc" "vpc" {
    cidr_block = var.cidr
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
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.cidr_pub
    map_public_ip_on_launch = true
    tags = {
      Name = "public_subnet"
    }
  
}
resource "aws_route_table" "public_RT" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name = "public-RT"
    }
  
}
resource "aws_route_table_association" "public" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public_RT.id
  
}
resource "aws_key_pair" "workspace" {
    key_name = "workspace"
    public_key = file("/home/codespace/.ssh/id_rsa.pub")
  
}

resource "aws_instance" "instance" {
    ami = var.ami
    subnet_id = aws_subnet.public.id
    instance_type = var.instance_type
    associate_public_ip_address = true
    
    key_name = aws_key_pair.workspace.key_name
    tags = var.tags
    
  
}
