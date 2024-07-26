provider "aws" {
    region = "us-east-1"
  
}

  

resource "aws_instance" "krishna" {
    ami = "ami-0583d8c7a9c35822c"
    subnet_id = "subnet-0e5a52327f4a325fd"
    instance_type = "t2.micro"
    key_name = "test"
    count = 3
    tags = {
        Name = "krishna-instance-${count.index +1}"
    }
}

resource "aws_instance" "My_instance" {
    ami = "ami-0583d8c7a9c35822c"
    subnet_id = "subnet-0e5a52327f4a325fd"
    instance_type = "t2.micro"
    key_name = "test"
    count = 2
    tags = {
        Name = "My_instance-instance-${count.index +1}"
    }
    
  
}
  
    
  
