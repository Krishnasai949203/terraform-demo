provider "aws" {
  region = "us-east-1"

}
#using count 
resource "aws_instance" "krishna" {
  ami           = "ami-0583d8c7a9c35822c"
  instance_type = "t2.micro"
  count         = 3
  tags = {
    Name = "krishna-instance-${count.index + 1}"
  }
}

#using loops -- count 
variable "aws_instances" {
  type    = list(string)
  default = ["dev", "stag", "prod"]

}
variable "tags" {
  type = map(string)
  default = {
    "dev"  = "dev-instance"
    "prod" = "prod-instance"
    "stag" = "stag-instance"
  }
}
resource "aws_instance" "ec2" {
  ami           = "ami-0583d8c7a9c35822c"
  instance_type = "t2.micro"
  count         = length(var.aws_instances)
  tags = {
    Name = var.tags[var.aws_instances[count.index]]
  }

#using loops - for each 
}
variable "instances" {
  type = map(object({
    ami           = string
    instance_type = string
  }))
  default = {
    "web" = {
      ami           = "ami-0583d8c7a9c35822c"
      instance_type = "t2.micro"

    }
    "db" = {
      ami           = "ami-0583d8c7a9c35822c"
      instance_type = "t2.micro"

    }
  }


}
resource "aws_instance" "demo" {
  for_each      = var.instances
  instance_type = each.value.instance_type
  ami           = each.value.ami
  tags = {
    Name = each.key
  }



}
