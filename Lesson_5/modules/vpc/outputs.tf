output "public_subnets" {
    value = {for i, q in aws_subnet.subnets : i => q.id}
}

output "vpc_id" {
    value = aws_vpc.aktan.id
}