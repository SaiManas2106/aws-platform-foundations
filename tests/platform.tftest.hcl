mock_provider "aws" {}

run "default_platform_has_private_and_public_network_tiers" {
  command = plan

  variables {
    name               = "platform-test"
    bucket_name        = "platform-test-example-bucket"
    availability_zones = ["eu-north-1a", "eu-north-1b"]
  }

  assert {
    condition     = length(output.public_subnet_ids) == 2
    error_message = "The default platform should expose one public subnet per configured AZ."
  }

  assert {
    condition     = length(output.private_subnet_ids) == 2
    error_message = "The default platform should expose one private subnet per configured AZ."
  }

  assert {
    condition     = output.bucket_name == "platform-test-example-bucket"
    error_message = "The secure bucket module should expose the configured bucket name."
  }
}

run "nat_is_opt_in_and_can_scale_per_az" {
  command = plan

  variables {
    name                 = "platform-ha-test"
    bucket_name          = "platform-ha-example-bucket"
    availability_zones   = ["eu-north-1a", "eu-north-1b"]
    enable_nat_gateways  = true
    nat_gateway_count    = 2
  }

  assert {
    condition     = length(module.network.nat_gateway_ids) == 2
    error_message = "The high-availability example should create one NAT gateway per configured AZ."
  }
}
