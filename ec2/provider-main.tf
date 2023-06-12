terraform {
  cloud {
    organization = "orenr2301"

    workspaces {
      name = "octoren"
    }
  }
}

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}

provider "aws" {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    region = "eu-central-1"
    profile = "default"
}


data "template_file" "ecr-init" {
  template = "user-data.tpl"

}

resource "aws_instance" "octo" {
  ami = data.aws_ami.octo_ami.id
  instance_type = var.instance_type
  vpc_security_group_ids = ["${aws_security_group.ec2-vm.id}"]
  iam_instance_profile = aws_iam_instance_profile.ec2-profile-octo-ec2-role.name
  
  tags = {
    Name = "octopus-vm"
    project = "octo"
  }

  key_name = "aws-internal"

  user_data =  templatefile("user-data.tftpl", { ecr_url = data.aws_ecr_repository.uri.repository_url,  ecr_region = var.aws_region })
  
}



