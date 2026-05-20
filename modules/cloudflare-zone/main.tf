resource "cloudflare_zone" "this" {
  account_id = var.account_id
  zone       = var.zone_name
  plan       = var.plan
}

resource "cloudflare_record" "this" {
  for_each = { for r in var.records : "${r.type}-${r.name}" => r }

  zone_id = cloudflare_zone.this.id
  name    = each.value.name
  type    = each.value.type
  content = each.value.value
  ttl     = each.value.ttl
  proxied = each.value.proxied
}

resource "cloudflare_zone_settings_override" "this" {
  zone_id = cloudflare_zone.this.id

  settings {
    ssl              = var.ssl_mode
    always_use_https = var.always_use_https ? "on" : "off"
    min_tls_version  = "1.2"
  }
}