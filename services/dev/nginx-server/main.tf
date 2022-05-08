terraform {
  backend "local" {}
}

provider "aws" {
	region = "us-east-2"
}

module "vpc" {
  source = "../../../modules/vpc"

  tags = {
    "Name": "nginx-server"
    "Environment" : "dev"
    "Owner": "elans.lacis"
  }
}
