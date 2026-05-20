output "zone_id"     { value = cloudflare_zone.this.id }
output "nameservers" { value = cloudflare_zone.this.name_servers }