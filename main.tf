provider "aws" {
	region = var.region
}

variable "region" {
	type  = string
	default = "us-east-2"
}

resource "aws_vpc" "main" {
	cidr_block = "10.0.0.0/16"
}