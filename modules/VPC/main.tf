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

resource "aws_vpc" "local" {
	cidr_block = "10.1.0.0/16"
}

resource "aws_subnet" "public_1" {
    vpc_id     = aws_vpc.main.id
	cidr_block = "10.0.1.0/24"

    tags = {
    Name = "public_1"
  }
}

resource "aws_subnet" "public_2" {
	vpc_id     = aws_vpc.main.id
	cidr_block = "10.0.2.0/24"

    tags = {
    Name = "public_2"
  }
}

resource "aws_subnet" "local_1" {
	vpc_id     = aws_vpc.local.id
	cidr_block = "10.0.3.0/24"

    tags = {
    Name = "local_1"
  }
}

resource "aws_subnet" "local_2" {
	vpc_id     = aws_vpc.local.id
	cidr_block = "10.0.4.0/24"

    tags = {
    Name = "local_2"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}
