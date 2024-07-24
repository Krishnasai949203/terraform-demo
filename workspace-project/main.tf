provider "aws" {
    region = "us-east-1"
  
}
variable "ami" {
    description = "ami for ec2 instance"
    type = map(string)
    default = {
      "dev" = "ami-03972092c42e8c0ca" #Amazon linux 2 ami for dev env
      "stag" = "ami-0583d8c7a9c35822c" #red hat ami for stag env
      "prod" = "ami-04a81a99f5ec58529" #ubuntu ami for prod env
    }
  
}
variable "instance_type" {
    description = "instance type of ec2 instance"
    type = map(string)
    default = {
      "dev" = "t3.micro"
      "stag" = "t2.micro"
      "prod" = "t2.medium"
    }
  
}
variable "cidr" {
    description = "cidr for vpc"
    type = map(string)
    default = {
      "dev" = "100.0.0.0/16"
      "stag" = "200.0.0.0/16"
      "prod" = "300.0.0.0/16"
    }
  
}
variable "cidr_pub" {
    description = "cidr for public subnet"
    type = map(string)
    default = {
      "dev" = "100.0.0.0/24"
      "stag" = "200.0.0.0/24"
      "prod" = "300.0.0.0/24"
     }
  
}
variable "tags" {
    description = "tags for ec2 instance"
    type = map(map(string))
    default = {
      "dev" = {
        Name = "dev-instance"
      }
      "stag" = {
        Name = "stag-instance"
      }
      "prod" = {
        Name = "prod-instance"
      }
     }
  
}
module "aws_instance" {
  source = "./ec2-instance"
  ami = lookup(var.ami, terraform.workspace, "error")
  instance_type = lookup(var.instance_type, terraform.workspace, "error")
  cidr = lookup(var.cidr, terraform.workspace, "error")
  cidr_pub = lookup(var.cidr_pub, terraform.workspace, "error")
  tags = lookup(var.tags, terraform.workspace, {"Name" = "error"})

  
}
