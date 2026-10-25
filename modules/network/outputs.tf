output "vpc_id" {
  description = "ID of the VPC."
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "IDs of public subnets keyed by availability zone."
  value       = { for az, subnet in aws_subnet.public : az => subnet.id }
}

output "private_subnet_ids" {
  description = "IDs of private subnets keyed by availability zone."
  value       = { for az, subnet in aws_subnet.private : az => subnet.id }
}

output "nat_gateway_ids" {
  description = "IDs of optional NAT gateways."
  value       = aws_nat_gateway.this[*].id
}
