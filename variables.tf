variable "region" {
  description = "AWS region for the example stack."
  type        = string
  default     = "eu-north-1"
}

variable "name" {
  description = "Short environment name used in resource tags."
  type        = string
  default     = "platform-lab"

  validation {
    condition     = can(regex("^[a-z0-9-]{3,20}$", var.name))
    error_message = "name must contain 3-20 lowercase letters, digits, or hyphens."
  }
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name for a real apply."
  type        = string
  default     = "replace-with-globally-unique-name"
}

variable "availability_zones" {
  description = "Availability zones used by the network module."
  type        = list(string)
  default     = ["eu-north-1a", "eu-north-1b"]

  validation {
    condition     = length(var.availability_zones) >= 2 && length(distinct(var.availability_zones)) == length(var.availability_zones)
    error_message = "Provide at least two distinct availability zones."
  }
}

variable "enable_nat_gateways" {
  description = "Whether to create NAT gateways. NAT gateways incur recurring charges."
  type        = bool
  default     = false
}

variable "nat_gateway_count" {
  description = "Number of NAT gateways when enabled. Use 1 for a lower-cost lab or one per AZ for higher availability."
  type        = number
  default     = 1

  validation {
    condition     = var.nat_gateway_count >= 1 && floor(var.nat_gateway_count) == var.nat_gateway_count && var.nat_gateway_count <= length(var.availability_zones)
    error_message = "nat_gateway_count must be a positive integer no greater than the number of availability zones."
  }
}
