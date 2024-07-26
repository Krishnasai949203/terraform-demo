terraform {
  backend "s3" {
    bucket = "krishnasai949203-s3-demo"
    key = "krishna/terraform.tfstate"
    region = "us-east-1"
    
  }
}
