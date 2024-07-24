variable "ami" {
    description = "ami for ec2 instance"
  
}
variable "instance_type" {
    description = "instance type of ec2 instance"
  
}
variable "cidr" {
    description = "cidr for vpc"
  
}
variable "cidr_pub" {
    description = "cidr for public subnet"
  
}
variable "tags" {
    description = "tags for ec2 instance"
    type = map(string)
  
}
