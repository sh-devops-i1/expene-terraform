output "vpc_id" {
  value = aws_vpc.main.id
}
output "frontend_subnet" {
  value = aws_vpc.main.*.id
}
output "backend_subnet" {
  value = aws_vpc.main.*.id
}
output "db_subnet" {
  value = aws_vpc.main.*.id
}
