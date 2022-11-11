provider "aws" {
    region = "us-east-1"
}

provider "aws" {
    alias = "us-east-2"
    region = "us-east-2"
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

resource "aws_s3_bucket" "dev4" {
  bucket = "s3-bucket-dev-4"
  acl = "private"

  tags = {
    Name = "s3-bucket-dev-4"
  }
}

resource "aws_instance" "dev5" {
    provider = aws.us-east-2
    ami = "ami-07693758d0ebc2111"
    instance_type = "t2.micro"
    key_name = "terraform-aws"
    tags = {
        Name = "dev-5"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2.id}"]
    depends_on = [aws_dynamodb_table.dynamodb-hml]
}

resource "aws_dynamodb_table" "dynamodb-hml" {
  provider = aws.us-east-2
  name           = "GameScores"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
}
