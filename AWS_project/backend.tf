terraform {
  backend "s3" {
    bucket = "krishnasai949203-s3-demo"
    key    = "krishna/aws_project.tf"
    region = "us-east-1"

  }
}
