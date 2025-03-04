terraform {
  backend "s3" {
    bucket = "aws-lambda-jenkins-remote-state-bucket-123456"
    key    = "aws-lambda-jenkins-pipeline/jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}