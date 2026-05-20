variable "name" {
  type        = string
  description = "Role name"
}

variable "description" {
  type    = string
  default = "Managed by acme-terraform-modules/iam-role"
}

variable "trust_policy" {
  type        = string
  description = "JSON trust policy document"
}

variable "managed_policy_arns" {
  type        = list(string)
  default     = []
  description = "AWS managed or customer-managed policy ARNs to attach"
}

variable "inline_policies" {
  type        = map(string)
  default     = {}
  description = "Map of inline policy name => JSON policy document"
}

variable "permissions_boundary_arn" {
  type        = string
  default     = null
  description = "Optional permissions boundary"
}

variable "max_session_duration" {
  type    = number
  default = 3600
}

variable "tags" {
  type    = map(string)
  default = {}
}