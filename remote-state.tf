terraform {
  backend "remote" {
    organization = "curso-terraform-alura-dev"

    workspaces {
      name = "aws-alura-terraform"
    }
  }
}
