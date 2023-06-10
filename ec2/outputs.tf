output "ec2_public_ip" {
  
  description = "ec2 public ip"
  value = aws_instance.octo.public_ip
}

output "ec2_url" {
    description = "ec2 public url dns"
    value = aws_instance.octo.public_dns
}


data "aws_ecr_repository" "uri" {
  #description = "get ecr devonce repository"
  name = "devone"
  
}

output "ecr-url" {
  description = "ec2 ecr"
  value = "${data.aws_ecr_repository.uri.repository_url}"
}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}


