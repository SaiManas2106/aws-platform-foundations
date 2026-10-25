variable "name" {
  description = "Name prefix for network resources."
  type        = string
}

variable "vpc_cidr" {
  description = "IPv4 CIDR block for the VPC."
  type        = string
}

variable "availability_zones" {
  description = "Distinct availability zones for subnet placement."
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) >= 2 && length(distinct(var.availability_zones)) == length(var.availability_zones)
    error_message = "At least two distinct availability zones are required."
  }
}

variable "public_subnet_cidrs" {
  description = "One public subnet CIDR per availability zone."
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) == length(var.availability_zones)
    error_message = "public_subnet_cidrs must have one entry per availability zone."
  }
}

variable "private_subnet_cidrs" {
  description = "One private subnet CIDR per availability zone."
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_cidrs) == length(var.availability_zones)
    error_message = "private_subnet_cidrs must have one entry per availability zone."
  }
}

variable "enable_nat_gateways" {
  description = "Whether private subnets receive outbound routes through NAT gateways."
  type        = bool
  default     = false
}

variable "nat_gateway_count" {
  description = "NAT gateway count when enabled; 1 saves cost, one per AZ improves isolation and availability."
  type        = number
  default     = 1

  validation {
    condition     = var.nat_gateway_count >= 1 && floor(var.nat_gateway_count) == var.nat_gateway_count && var.nat_gateway_count <= length(var.availability_zones)
    error_message = "nat_gateway_count must be a positive integer no greater than the number of availability zones."
  }
}

variable "tags" {
  description = "Tags applied to created resources."
  type        = map(string)
  default     = {}
}
