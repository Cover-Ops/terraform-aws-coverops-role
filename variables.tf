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
  description = "Name of the IAM role."
  type        = string
  default     = "CoverOpsAccess"
}

variable "role_path" {
  description = "IAM path for the role, if your account files vendor roles under one (e.g. /vendors/)."
  type        = string
  default     = "/"
}

variable "permissions_boundary" {
  description = "ARN of a permissions boundary your account requires on new roles, or null."
  type        = string
  default     = null
}

variable "environment" {
  description = "Which environment this account is: production, staging or development."
  type        = string
  validation {
    condition     = contains(["production", "staging", "development"], var.environment)
    error_message = "Use production, staging or development."
  }
}

variable "owner" {
  description = "Who answers for this account: a team or a person's email. Goes in the Owner tag."
  type        = string
}

variable "project" {
  description = "Value of the Project tag."
  type        = string
  default     = "coverops"
}

variable "cost_centre" {
  description = "Cost centre or budget line for the CostCentre tag, e.g. engineering."
  type        = string
  default     = "engineering"
}

variable "extra_tags" {
  description = "More tags to add to the role."
  type        = map(string)
  default     = {}
}
