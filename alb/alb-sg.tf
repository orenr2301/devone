resource aws_security_group "octo-lb-sg" {
    name = "octo-alb-task-sg"
    vpc_id = "${data.aws_vpc.default_octo.id}"
}


resource "aws_security_group_rule" "octo-in-http" {
    from_port = 80
    protocol = "tcp"
    security_group_id = "${aws_security_group.octo-lb-sg.id}"
    to_port = 80
    type = "ingress"
    cidr_blocks = ["0.0.0.0/0"]
  
}

resource "aws_security_group_rule" "octo-out-all" {
    from_port = 0
    protocol = "-1"
    to_port = 0
    security_group_id = "${aws_security_group.octo-lb-sg.id}"
    type = "egress"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_lb_listener" "octo-alb-listener" {
    load_balancer_arn = "${aws_lb.octo-aws-lb.arn}"
    port = 80
    protocol = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = "${aws_lb_target_group.octo-target-group.arn}"
    }
  
}