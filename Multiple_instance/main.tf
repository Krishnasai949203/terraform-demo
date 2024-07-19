provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "krishna" {
    ami = "ami-0583d8c7a9c35822c"
    instance_type = "t2.micro"
    key_name = "test"
    count = 5

    tags = {
      Name = "krishna-instance-${count.index + 1}"
    }
}
output "instance_public_ips" {
    description = "public ips of ec2 instances"
    value = aws_instance.krishna.*.public_ip
}
output "instance_ids" {
    description = "instance id's"
    value = aws_instance.krishna[*].id
  
}
  
