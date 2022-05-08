output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnet_arn" {
  value = aws_subnet.private.arn
}

output "public_subnet_arn" {
  value = aws_subnet.public.arn
}

output "nat" {
  value = aws_nat_gateway.nat
}
