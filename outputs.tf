output "vpc_id" {
  description = "ID of the example VPC."
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets."
  value       = module.network.private_subnet_ids
}

output "bucket_name" {
  description = "Name of the hardened S3 bucket."
  value       = module.secure_bucket.bucket_name
}
