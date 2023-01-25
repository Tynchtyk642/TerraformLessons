output "public_subnets" {
    value = aws_subnet.subnets[*].id
}

output "vpc_id" {
    value = aws_vpc.aktan.id
}