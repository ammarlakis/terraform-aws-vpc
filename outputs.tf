output "vpc_id" {
  description = "The VPC ID"
  value       = aws_vpc.this.id
}

output "public_subnets" {
  description = "The public subnets ids and cidrs"

  value = { for availabiltiy_zone, subnet in aws_subnet.public : availabiltiy_zone => {
    id   = subnet.id
    cidr = subnet.cidr_block
  } }
}

output "private_subnets" {
  description = "The private subnets ids and cidrs"

  value = { for availabiltiy_zone, subnet in aws_subnet.private : availabiltiy_zone => {
    id   = subnet.id
    cidr = subnet.cidr_block
  } }
}
