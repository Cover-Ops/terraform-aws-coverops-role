# Let CoverOps read a startup's production account, read-only.
provider "aws" {
  region = "ap-south-1" # IAM is global; any region works
}

module "coverops" {
  source = "../.."
  # After publishing: source = "github.com/Cover-Ops/terraform-aws-coverops-role?ref=v1.3.0"

  external_id = "paste-the-external-id-from-coverops"
  environment = "production"
  owner       = "platform@acme.example"
}

output "role_arn" {
  description = "Paste this back into CoverOps."
  value       = module.coverops.role_arn
}
