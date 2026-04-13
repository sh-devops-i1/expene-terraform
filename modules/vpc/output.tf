output "vpc_id" {
  value = aws_vpc.main.id
}
output "frontend_subnet" {
  value = aws_subnet.frontend_subnet.*.id
}
output "backend_subnet" {
  value = aws_subnet.backend_subnet.*.id
}
output "db_subnet" {
  value = aws_subnet.db_subnets.*.id
}
output "public_subnet" {
  value = aws_subnet.public_subnets.*.id
}