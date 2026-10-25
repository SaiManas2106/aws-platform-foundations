locals {
  common_tags = {
    Project     = var.name
    Environment = "example"
    ManagedBy   = "Terraform"
  }
}

module "network" {
  source = "./modules/network"

  name                 = var.name
  vpc_cidr             = "10.40.0.0/16"
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = ["10.40.0.0/24", "10.40.1.0/24"]
  private_subnet_cidrs = ["10.40.16.0/20", "10.40.32.0/20"]
  enable_nat_gateways  = var.enable_nat_gateways
  nat_gateway_count    = var.nat_gateway_count
  tags                 = local.common_tags
}

module "secure_bucket" {
  source = "./modules/secure_bucket"

  bucket_name = var.bucket_name
  tags        = local.common_tags
}
