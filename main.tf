# CoverOps Marketplace kit: the CoverOps access role. Apache 2.0.
# The policies in policies/ are the same ones the CoverOps connect wizard and
# CloudFormation template show. They are generated from the platform, so don't
# edit them by hand.

locals {
  tags = merge(var.extra_tags, {
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
    CostCentre  = var.cost_centre
    ManagedBy   = "terraform"
    Kit         = "coverops/aws-coverops-role"
  })
}

resource "aws_iam_role" "coverops" {
  name                 = var.role_name
  path                 = var.role_path
  permissions_boundary = var.permissions_boundary
  max_session_duration = 3600
  tags                 = local.tags
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "CoverOpsAssumeRole"
      Effect    = "Allow"
      Principal = { AWS = var.trusted_principal }
      Action    = "sts:AssumeRole"
      # Without the External ID, anyone who learns the role ARN could ask CoverOps to assume it.
      Condition = { StringEquals = { "sts:ExternalId" = var.external_id } }
    }]
  })
}

resource "aws_iam_role_policy" "coverops" {
  name   = "CoverOpsAccess"
  role   = aws_iam_role.coverops.id
  policy = file("${path.module}/policies/${var.access_level}.json")
}
