output "aws_course_vpc_id" {
  value = aws_vpc.aws_course.id
}

output "security_vpc_id" {
  value = aws_vpc.security.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "security_subnet_id" {
  value = aws_subnet.security_private.id
}
