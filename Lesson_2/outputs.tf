output "mintemir" {
  value = "birinchi-etaj"
}

output "vpc_id" {
  value = aws_vpc.main
}

output "route_table" {
  description = ""
  value       = aws_route_table.example.id
  sensitive   = true
}