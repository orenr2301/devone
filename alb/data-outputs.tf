variable "vpc_id" {
  default = null
}

data "aws_vpc"  "default_octo" {
  id = var.vpc_id
  
}


output "vpc_id_default" {
  value = data.aws_vpc.default_octo.id
  
}


variable "ec2-id" {
    default = null
}

data "aws_instance" "ec2-octo-instances" {
    instance_id = var.ec2-id
    filter {
      name = "tag:Name"
      values = [ "octopus-vm" ]
      }
    }
    

output "vpc_ec2_id" {
    value =  data.aws_instance.ec2-octo-instances.id
}



data "aws_subnets" "octo-all" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.default_octo.id]
  }
}


output "first_subnet_id" {
  value = sort(data.aws_subnets.octo-all.ids)[2]  
}

output "second_subnet_id" {
  value = sort(data.aws_subnets.octo-all.ids)[1] 
  
}



locals {
   subnet_1 = sort(data.aws_subnets.octo-all.ids)[2]
   subnet_2 = sort(data.aws_subnets.octo-all.ids)[1]
}
