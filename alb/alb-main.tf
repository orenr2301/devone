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


/* /* resource "aws_subnet" "primary" {
  availability_zone = data.aws_availability_zone.octo-available.names[0]
  vpc_id = "${data.aws_vpc.default_octo.id}"
}

resource "aws_subnet" "secondary" {
    availability_zone = data.aws_availability_zone.octo-available.names[1]
    vpc_id = "${data.aws_vpc.default_octo.id}" }*/


resource "aws_lb_target_group" "octo-target-group" {
     health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "my-test-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id = "${data.aws_vpc.default_octo.id}"

}


resource "aws_lb_target_group_attachment" "octo-alb-tg-attach" {

    target_group_arn = "${aws_lb_target_group.octo-target-group.arn}"
    target_id = "${data.aws_instance.ec2-octo-instances.id}"
    port = 80
}

resource "aws_lb" "octo-aws-lb" {
    name = "octo-alb"
    internal = false

    security_groups = [
        "${aws_security_group.octo-lb-sg.id}",
    ]


    subnets = [ 
        local.subnet_1,
        local.subnet_2
     ]


    tags = {
      Name = "octo-task-alb"
    }

    ip_address_type = "ipv4"
    load_balancer_type = "application"
}


