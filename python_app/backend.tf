terraform {
  backend "s3" {
    region = "us-east-1"
    bucket = "krishnasai949203-s3-demo"
    key = "krishna/python.tfstate"

    
    
  }
}
