# Generated from coverops_backend/src/providers/aws/policy.ts — do not edit by hand.
resource "aws_iam_role" "coverops" {
  name                 = var.role_name
  max_session_duration = 3600
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
