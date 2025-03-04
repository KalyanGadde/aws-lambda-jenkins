variable "bucket_name" {
  type        = string
  description = "Remote state bucket name"
}

variable "vpc_name" {
  type        = string
  description = "AWS Lambda VPC Name"
}

variable "private_subnet_1" {
  type        = string
  description = "Private Subnet 1"
}

variable "private_subnet_2" {
  type        = string
  description = "Private Subnet 2"
}
variable "existing_sg" {
  type        = string
  description = "Security Group"
}

/*
variable "vpc_cidr" {
  type        = string
  description = "Public Subnet CIDR values"
}

variable "vpc_name" {
  type        = string
  description = "DevOps Project 1 VPC 1"
}

variable "cidr_public_subnet" {
  type        = list(string)
  description = "Public Subnet CIDR values"
}

variable "cidr_private_subnet" {
  type        = list(string)
  description = "Private Subnet CIDR values"
}

variable "us_availability_zone" {
  type        = list(string)
  description = "Availability Zones"
}

variable "public_key" {
  type        = string
  description = "DevOps Project 1 Public key for EC2 instance"
}

variable "ec2_ami_id" {
  type        = string
  description = "DevOps Project 1 AMI Id for EC2 instance"
}
*/