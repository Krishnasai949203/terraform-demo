resource "aws_instance" "test" {
    ami           = var.ami
    instance_type = var.instance_type
    key_name = "demo"
    subnet_id     = aws_subnet.public.id
    provider = aws.us-west-2
    tags = {
        Name = "My_instance"
    }
  
}