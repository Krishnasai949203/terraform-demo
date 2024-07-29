provider "aws" {
    region = "us-east-1"
  
}
variable "bucket" {
    type = bool
    default = true
  
}
resource "aws_s3_bucket" "krishna" {
    bucket = "krishnasai949203-conditions-demo"
    count = var.bucket ? 1 : 0 
    
  
}
variable "instance" {
    type = string
    default = "prod"
  
}
variable "tags" {
    type = map(map(string))
    default = {
      "dev" = {
        Name =  "dev_instance"
      }
      "prod" = {
        Name = "prod_instance"
      }
      "stag" = {
        Name = "stag_instance"
      }
    }
}
resource "aws_instance" "ec2" {
     ami           = "ami-0583d8c7a9c35822c"
    instance_type = "t2.micro"
    count = var.instance == "prod" ? 3 : 1
    tags = var.tags[var.instance]
    
  
}
