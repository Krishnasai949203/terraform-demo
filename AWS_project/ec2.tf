resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "ssh & http sg rules"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

}


resource "aws_instance" "webserver1" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = "vault"
  subnet_id       = aws_subnet.pub1.id
  security_groups = [aws_security_group.web_sg.id]
  user_data       = base64encode(file("userdata1.sh"))
  tags = {
    Name = "webserver-1"
  }

}

resource "aws_instance" "webserver2" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = "vault"
  subnet_id       = aws_subnet.pub2.id
  security_groups = [aws_security_group.web_sg.id]
  user_data       = base64encode(file("userdata2.sh"))
  tags = {
    Name = "webserver-2"
  }

}
