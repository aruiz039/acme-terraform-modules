variable "name" {
  type = string
}

variable "description" {
  type    = string
  default = "Managed by acme-terraform-modules/security-group"
}

variable "vpc_id" {
  type = string
}

variable "ingress_rules" {
  type = list(object({
    description      = string
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = optional(list(string), [])
    source_sg_ids    = optional(list(string), [])
    prefix_list_ids  = optional(list(string), [])
  }))
  default = []
}

variable "egress_rules" {
  type = list(object({
    description      = string
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = optional(list(string), [])
    source_sg_ids    = optional(list(string), [])
    prefix_list_ids  = optional(list(string), [])
  }))
  default = [{
    description = "Allow all egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }]
}

variable "tags" {
  type    = map(string)
  default = {}
}