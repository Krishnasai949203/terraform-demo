module "aws_instance" {
    source = "./ec2"
    ami = "ami-0583d8c7a9c35822c"
    instance_type = "t2.micro"
  
}
