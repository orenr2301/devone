variable "aws_access_key" {
    description = "AWS access key"
    type = string
    default = null
}

variable "aws_secret_key" {
    description =  "AWS secret key"
    type = string
    default = null
}

variable "aws_region" {
    description = "AWS region"
    type = string
    default = "eu-central-1"
}


variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "aws_ec2_ami" {
    description = "AMI image"
    type = string
    default = null
}


variable "set_vpc" {
    type = string
    description = "aws vpc-id" 
    default = null     
}

variable "set_cidr" {
    type = list(string)
    description = "aws vpc cider to set"
    default = null
}


data "aws_ami" "octo_ami" {
    most_recent = true
    owners = ["amazon"]

    filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-ebs"]
    }
  
}

variable "s3_name" {
    description = "s3 bucket name"
    type = string
    default = "octo-oren-bucket"
}