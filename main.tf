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
    vpc_security_group_ids = ["sg-0ca6a03c9950d009c"]
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
