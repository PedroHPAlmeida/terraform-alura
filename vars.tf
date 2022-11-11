variable "amis" {
  type = map(string)

  default = {
    "us-east-1" = "ami-0149b2da6ceec4bb0",
    "us-east-2" = "ami-07693758d0ebc2111"
  }
}

variable "cdirs_acesso_remoto" {
    type = list(string)

    default = ["45.173.90.72/32"] # IP dinâmico (verificar IP no site https://www.whatismyip.com/ toda vez que for fazer acesso SSH)
}

variable "key_name" {
  type = string
  default = "terraform-aws"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}