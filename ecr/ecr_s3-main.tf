
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}

provider "aws" {
    /* access_key = var.aws_access_key
    secret_key = var.aws_secret_key */
    region = "eu-central-1"
    profile = "default"
}



resource "aws_ecr_repository" "ecr" {
    for_each = toset(var.ecr_name)
    name = each.key
    image_tag_mutability = var.image_mutability

    encryption_configuration {
      encryption_type = var.encrypt_type
    }

    image_scanning_configuration {
      scan_on_push = false
    }

    tags = var.tags 
  
}

resource "aws_s3_bucket" "octo_s3" {
  bucket = "${var.s3_name}"
  force_destroy = true

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = "${var.s3_name}"
    Environment = "test"
  }
}


