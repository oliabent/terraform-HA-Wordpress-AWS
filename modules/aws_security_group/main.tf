resource "aws_security_group" "allow_http_lb" {
  name        = "allow http on lb"
  description = "Allow http inbound traffic on lb"
  vpc_id      = var.vpc_id

  ingress {
    description      = "http from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}



resource "aws_security_group" "allow_http_instance" {
  name        = "http internal"
  description = "Allow http inbound traffic from LB to instance"
  vpc_id      = var.vpc_id

  ingress {
    description      = "http from LB"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [aws_security_group.allow_http_lb.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "allow_mysql" {
  name        = "allow connection from instance to mysql"
  description = "allow connection from instance to mysql"
  vpc_id      = var.vpc_id

  ingress {
    description      = "mysql"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [aws_security_group.allow_http_instance.id]
  }
}


resource "aws_security_group" "allow_nfc" {
  name        = "nfc"
  description = "Allow nfc inbound traffic from instance to EFS"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow nfc inbound traffic from instance to EFS"
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    security_groups  = [aws_security_group.allow_http_instance.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}