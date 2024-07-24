provider "aws" {
    region = "us-east-1"
  
}
variable "ami" {
    description = "ami of ec2-instance"
  
}
variable "instance_type"{
    description = "instance type for ec2"
    type = map(string)

    default = {
      "dev" = "t2.micro"
      "stage" = "t2.medium"
      "prod" = "t3.micro"
    }

    
  
}
variable "tags" {
    description = "give tag name"
    type = map(string)
    default = {
      "dev" = "dev_instance"
      "stage" = "stage_instance"
      "prod" = "prod_instance"
    }
  
}
module "aws_instance" {
    source = "./modules/ec2-instance"
    ami = var.ami
    instance_type = lookup(var.instance_type, terraform.workspace, "error")
    tags = {
        Name = lookup(var.tags,terraform.workspace, "error")
    }
