variable "attachment_id" {
  type        = string
  description = "TGW attachment ID (usually output by the VPC module)"
}

variable "associated_route_table_id" {
  type        = string
  description = "TGW route table this attachment is associated with"
}

variable "propagated_route_table_ids" {
  type        = list(string)
  default     = []
  description = "TGW route tables this attachment propagates routes to"
}