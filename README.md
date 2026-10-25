# AWS Platform Foundations

Reusable Terraform foundations for a small AWS application environment. The project composes a VPC module with public/private subnet separation and an S3 module with public-access blocking, encryption, and versioning. It includes Terraform-native plan tests with a mocked AWS provider and a CI workflow that formats, validates, and tests the configuration without AWS credentials.

## Scope and safety

This is a portfolio project and has not been applied to an AWS account. The plan tests use a mocked provider; they do not prove a real deployment or replace an AWS integration test. Applying the example creates billable resources, especially if NAT gateways are enabled. Review the plan, region, CIDRs, and expected costs before any real apply, and destroy test resources promptly.

## Layout

```text
modules/
  network/          VPC, public/private subnets, route tables, optional NAT
  secure_bucket/    S3 bucket hardening defaults
tests/              mocked Terraform plan assertions
.github/workflows/  format, validate, and test checks
main.tf             example composition
```

## Requirements

- Terraform 1.9 or later
- AWS provider 5.x

The default configuration creates no resources until `terraform apply` is run. The example disables NAT gateways by default so a reviewer can inspect the plan without silently opting into a recurring NAT charge.

## Validate and test locally

Run these commands from this directory:

```bash
terraform fmt -check -recursive
terraform init -backend=false
terraform validate
terraform test
```

The tests use `mock_provider "aws"` and do not require AWS credentials. For an actual deployment, configure credentials using an approved AWS identity mechanism, set a globally unique S3 bucket name, and review `terraform plan` before applying.

## Design notes

- The network module accepts explicit availability zones and subnet CIDRs, making topology choices visible to callers.
- NAT gateways are opt-in and can be limited to one per VPC for a lower-cost development setup.
- The bucket module blocks public ACLs and policies, enables bucket versioning, and enforces server-side encryption.
- Modules expose only the identifiers and values needed by consuming stacks.
- CI runs formatting, initialization, validation, and mocked plan tests; it does not deploy infrastructure.

## Limitations

This repository is an educational module composition, not an AWS Landing Zone, EKS platform, or production-ready network baseline. It does not configure multi-account governance, centralized egress, Cloud WAN, flow logs, KMS key policies, or organization-wide security controls. Those require environment-specific architecture and review.
