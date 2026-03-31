output "vpc_id" {
  description = "The unique identifier of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "The CIDR block associated with the VPC."
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "A set of IDs for all public subnets"
  value = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id,
    aws_subnet.public_c.id
  ]
}

output "public_subnet_cidr_block" {
  description = "A set of CIDR's block for all public subnets"
  value = [
    aws_subnet.public_a.cidr_block,
    aws_subnet.public_b.cidr_block,
    aws_subnet.public_c.cidr_block
  ]
}

output "public_subnet_availability_zone" {
  description = "A set of AZ's for all public subnets"
  value = [
    aws_subnet.public_a.availability_zone,
    aws_subnet.public_b.availability_zone,
    aws_subnet.public_c.availability_zone
  ]
}

output "internet_gateway_id" {
  description = "The unique identifier of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "routing_table_id" {
  description = "The unique identifier of the routing table"
  value       = aws_route_table.route_table
}