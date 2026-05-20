variable "zone_name" {
  type        = string
  description = "The domain (e.g., 'acme-yourname.com')"
}

variable "account_id" {
  type        = string
  description = "Cloudflare account ID"
}

variable "plan" {
  type    = string
  default = "free"
}

variable "records" {
  type = list(object({
    name    = string
    type    = string
    value   = string
    ttl     = optional(number, 1)   # 1 = auto
    proxied = optional(bool, false)
  }))
  default = []
}

variable "ssl_mode" {
  type    = string
  default = "full"   # full, strict, flexible, off
}

variable "always_use_https" {
  type    = bool
  default = true
}