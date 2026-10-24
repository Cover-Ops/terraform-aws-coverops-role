variable "external_id" {
  description = "The External ID CoverOps shows when you add the account. Unique to your organisation."
  type        = string
}

variable "access_level" {
  description = "read_only, or read_write for actions on resources you tag coverops:managed=true."
  type        = string
  default     = "read_only"
  validation {
    condition     = contains(["read_only", "read_write"], var.access_level)
    error_message = "access_level is read_only or read_write."
  }
}

variable "trusted_principal" {
  description = "The CoverOps identity that assumes the role."
  type        = string
  default     = "arn:aws:iam::007576455930:user/coverops-control-plane"
}

variable "role_name" {
  type    = string
  default = "CoverOpsAccess"
}
