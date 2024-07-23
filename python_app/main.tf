resource "aws_vpc" "vpc" {
    cidr_block = var.cidr
    provider = aws.us-east-1
    tags = {
      Name = "vpc"
    }
  
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    provider = aws.us-east-1
    tags =  {
        Name = "igw"
    }
  
}
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.cidr_pub
    availability_zone  = "us-east-1a"
    map_public_ip_on_launch = true
    provider = aws.us-east-1
    tags = {
      Name = "pub_subnet"
    }
  
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.vpc.id
    provider = aws.us-east-1
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name = "public_rt"
    }
        
    
  
}
resource "aws_route_table_association" "public" {
    provider = aws.us-east-1
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public.id
  
}

resource "aws_key_pair" "python" {
    key_name = "python"
    public_key = file("/home/codespace/.ssh/id_rsa.pub")
  
}
resource "aws_security_group" "python_SG" {
    name = "pyhton_SG"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "http port"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress  {
        description = "ssh"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
        
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    }
    tags = {
        Name = "python_SG"
    }
}

resource "aws_instance" "python" {
    ami = var.ami
    instance_type = var.instance_type
    provider = aws.us-east-1
    subnet_id = aws_subnet.public.id
    key_name = aws_key_pair.python.key_name
    vpc_security_group_ids = [aws_security_group.python_SG.id]
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
      host = self.public_ip
    }
    tags = {
        Name = "pyhton_instance"
    }
    provisioner "file" {
      source      = "app.py"
      destination = "/home/ec2-user/app.py"

   }
    provisioner "remote-exec" {
       inline = [
         "echo 'Hello from the remote instance'",
         "sudo yum update -y",  
         "sudo yum install -y python3-pip",  
         "cd /home/ec2-user",
         "sudo pip3 install flask",
         "sudo python3 app.py ",
        ]
    }
}
  


  
