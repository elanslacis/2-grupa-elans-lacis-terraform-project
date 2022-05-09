data "aws_ami" "ubuntu" {
    most_recent = true
    subnet_id = aws_subnet.public.id
    gateway_id = aws_internet_gateway.igw.id

    filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20220419"]
    # ami-0eea504f45ef7a8f7
    }

}

resource "aws_instance" "web" {
    ami           = data.aws_ami.ubuntu.id
    instance_type = "t3.micro"

    tags = var.tags
}