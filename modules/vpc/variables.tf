variable "name" {
  type        = string
  description = "Name prefix for all resources (e.g., 'dev-app')"
}

variable "cidr" {
  type        = string
  description = "CIDR block for the VPC (e.g., '10.10.0.0/16')"
}

variable "azs" {
  type        = list(string)
  description = "List of availability zones to deploy into"

  validation {
    condition     = length(var.azs) >= 2
    error_message = "At least 2 AZs are required for HA."
  }
}

variable "public_subnets" {
  type        = list(string)
  description = "Public subnet CIDRs, one per AZ"
  default     = []
}

variable "private_subnets" {
  type        = list(string)
  description = "Private subnet CIDRs, one per AZ"
  default     = []
}

variable "tgw_subnets" {
  type        = list(string)
  description = "Small subnets (e.g., /28) dedicated to TGW ENIs, one per AZ"
  default     = []
}

variable "enable_nat_gateway" {
  type        = bool
  default     = true
  description = "Whether to create NAT gateways for private subnet egress"
}

variable "single_nat_gateway" {
  type        = bool
  default     = false
  description = "Use one NAT gateway instead of one per AZ (cheaper, less HA)"
}

variable "tgw_id" {
  type        = string
  default     = null
  description = "If set, attach this VPC to the given Transit Gateway"
}

variable "tgw_destinations" {
  type        = list(string)
  default     = []
  description = "CIDR blocks to route via the TGW (e.g., ['10.0.0.0/8'])"
}

variable "enable_flow_logs" {
  type        = bool
  default     = true
  description = "Send VPC flow logs to CloudWatch"
}

variable "flow_logs_retention_days" {
  type    = number
  default = 30
}

variable "tags" {
  type    = map(string)
  default = {}
}