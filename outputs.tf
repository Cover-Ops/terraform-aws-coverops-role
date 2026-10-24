output "role_arn" {
  description = "Paste this back into CoverOps."
  value       = aws_iam_role.coverops.arn
}
