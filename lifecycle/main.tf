provider "aws" {
  region = "us-east-1"

}
resource "aws_instance" "dev" {
  ami           = "ami-0583d8c7a9c35822c"
  instance_type = "t2.micro"
  lifecycle {
    prevent_destroy = true
  }
  tags = {
  Name = "dev" }
}
resource "aws_instance" "stag" {
  ami           = "ami-0583d8c7a9c35822c"
  instance_type = "t3.micro"

  lifecycle {
    create_before_destroy = true
  }
  tags = {
  Name = "stag" }
}


resource "aws_instance" "prod" {
  ami           = "ami-0583d8c7a9c35822c"
  instance_type = "t2.micro"
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  tags = {
    Name = "prod"
  }
}

