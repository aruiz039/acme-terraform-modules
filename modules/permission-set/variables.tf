variable "name" {
  type = string
}

variable "description" {
  type    = string
  default = ""
}

variable "session_duration" {
  type        = string
  default     = "PT1H"
  description = "ISO 8601 duration. How long sessions last (e.g., PT1H, PT8H)"
}

variable "instance_arn" {
  type        = string
  description = "ARN of the IAM Identity Center instance"
}

variable "managed_policy_arns" {
  type    = list(string)
  default = []
}

variable "inline_policy" {
  type    = string
  default = null
}

variable "permissions_boundary_arn" {
  type    = string
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}