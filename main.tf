provider "aws" {
    region = "us-east-1"
}


resource "aws_instance" "dev" {
    count = 3
    ami = "ami-0149b2da6ceec4bb0"
    instance_type = "t2.micro"
    key_name = "terraform-aws"
    tags = {
        Name = "dev-${count.index}"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}

resource "aws_instance" "dev4" {
    ami = "ami-0149b2da6ceec4bb0"
    instance_type = "t2.micro"
    key_name = "terraform-aws"
    tags = {
        Name = "dev-4"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
    depends_on = [aws_s3_bucket.dev4]
}

resource "aws_security_group" "acesso-ssh" {
  name        = "acesso-ssh"
  description = "acesso-ssh"

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["45.173.91.152/32"]
  }

  tags = {
    Name = "ssh"
  }
}

resource "aws_s3_bucket" "dev4" {
  bucket = "s3-bucket-dev-4"
  acl = "private"

  tags = {
    Name = "s3-bucket-dev-4"
  }
}
