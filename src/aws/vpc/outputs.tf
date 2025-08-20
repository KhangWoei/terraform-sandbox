output "vpc_id" {
  description = "Id for the created VPC"
  value       = aws_vpc.test_environment.id
}
