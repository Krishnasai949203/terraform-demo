resource "aws_vpc" "myvpc" {
    cidr_block = "200.0.0.0/16"
    tags = {
        Name = "myvpc"
        }
  
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
        Name = "IGW"
        }
  
}
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "200.0.1.0/24"
    tags = {
        Name = "public_subnet"
        }
  
}
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.myvpc.id
    route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "public_RT"
        }
    
  
}
resource "aws_route_table_association" "public" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public.id
  
}


resource "aws_instance" "test" {

    ami = var.ami
    key_name = aws_key_pair.trick.key_name
    instance_type = var.instance_type
    subnet_id = aws_subnet.public.id
    provider = aws.us-east-1
    vpc_security_group_ids = [aws_security_group.sg.id]
    tags = {
        Name = "test_instance"
        }
  
}
resource "aws_key_pair" "trick" {
  key_name   = "trick"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}
resource "aws_security_group" "sg" {
  name        = "sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  tags = {
    Name = "SG"
  }
}
resource "aws_security_group_rule" "SG_rule" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
}
  
