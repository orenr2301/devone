resource "aws_security_group" "ec2-vm" {
    name = "ec2-vm-sc"
    description = "Allow Incoming connections"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow Incoming HTTP connections"
    }
    
    ingress  {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow Incoming HTTPS connections"
    }

    ingress  {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow Incoming SSH connections"
    }


    ingress  {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow Incoming icmp connections"
    }

    egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    description =  "All egress traffic"
  }

  tags = {
    Name = "terraform-ec2-sg"
  }
}


resource "aws_iam_role" "octo-ec2-role" {
  name = "octo-ec2-ecr"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
  
  tags = {
    project = "octo"
  }
}

resource "aws_iam_instance_profile" "ec2-profile-octo-ec2-role" {
  name = "ec2_pfogile_octo_ec2_role"
  role = aws_iam_role.octo-ec2-role.name
}

resource "aws_iam_role_policy" "octo_ec2_policy" {
  name = "octo_ec2_policy"
  role = aws_iam_role.octo-ec2-role.id

    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability",
        "ecr:CompleteLayerUpload",
        "ecr:GetDownloadUrlForLayer",
        "ecr:InitiateLayerUpload",
        "ecr:PutImage",
        "ecr:UploadLayerPart"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}