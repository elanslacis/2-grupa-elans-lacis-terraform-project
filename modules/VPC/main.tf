provider "aws" {
	region = "us-east-2"
}

resource "aws_vpc" "main" {
	cidr_block = "10.0.0.0/16"
    tags = {
        Name = "Main VPC"
    }
}


resource "aws_subnet" "public" {
	vpc_id     = aws_vpc.main.id
	cidr_block = ["10.0.1.0/24", "10.0.2.0/24"]

	tags = {
		Name = "public"
	}
}


resource "aws_subnet" "private" {
	vpc_id     = aws_vpc.main.id
	cidr_block = ["10.0.3.0/24", "10.0.4.0/24"]

		tags = {
		Name = "private"
	}
}



resource "aws_internet_gateway" "igw" {
	vpc_id = aws_vpc.main.id

	tags = {
		Name = "Main Internet Gateway"
	}
	
}

resource "aws_eip" "nat_eip" {
	vpc = true
	depends_on = [aws_internet_gateway.igw]
	tags = {
		Name = "NAT Gateway EIP"
	}
}


resource "aws_nat_gateway" "nat" {
	allocation_id = aws_eip.nat_eip.id
	subnet_id = aws_subnet.public.id

	tags = {
		Name = "Main NAT Gateway"
	}
}

resource "aws_route_table" "public" {
	vpc_id = aws_vpc.main.id

	route = [ {
	  cidr_block = "0.0.0.0/0"
	  gateway_id = aws_internet_gateway.igw.id
	} ]
}

resource "aws_route_table_association" "public" {
	subnet_id = aws_subnet.public.id
	route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
	vpc_id = aws_vpc.main.id

	route = [ {
	  cidr_block = "0.0.0.0/0"
	  gateway_id = aws_nat_gateway.nat.id
	} ]
}	

resource "aws_route_table_association" "private" {
	subnet_id = aws_subnet.private.id
	route_table_id = aws_route_table.private.id
}


resource "aws_security_group" "sg" {
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "HTTP"
    cidr_blocks      = "0.0.0.0/0"

  }
    ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "HTTPS"
    cidr_blocks      = "0.0.0.0/0"

  }
    ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "SSH"
	cidr_blocks 	 = "62.85.31.62"
  }
}