
provider "aws" {
region = "us-east-1"
}

resource "aws_instance" "xx" {
  ami             = "ami-06aa3f7caf3a30282"
  instance_type   = "t2.micro"
  key_name        = "sad"
  subnet_id       = "subnet-0fb501111b6d99a0b"
  vpc_security_group_ids = [aws_security_group.jj.id]
  availability_zone = "us-east-1a"
  user_data       = <<EOF
#!/bin/bash
sudo -i
apt install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my app created by terraform infrastructurte by raham sir server-1" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-1"
  }
}

resource "aws_instance" "xy" {
  ami             = "ami-06aa3f7caf3a30282"
  instance_type   = "t2.micro"
  key_name        = "sad"
  subnet_id       = "subnet-0fb501111b6d99a0b"
  vpc_security_group_ids = [aws_security_group.jj.id]
  availability_zone = "us-east-1a"
  tags = {
    Name = "app-server-1"
  }
}

resource "aws_security_group" "jj" {
  name = "elb-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "kk" {
  bucket = "devopsb9"
}

resource "aws_iam_user" "ll" {
for_each = var.user_names
name = each.value
}

variable "user_names" {
description = "*"
type = set(string)
default = ["user1", "user2", "user3", "user4"]
}

resource "aws_ebs_volume" "aa" {
 availability_zone = "us-east-1a"
  size = 40
  tags = {
    Name = "ebs-001"
  }
}
