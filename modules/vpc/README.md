````markdown
# VPC Module

Creates a multi-AZ VPC with public, private, and optional TGW-attachment subnets.

## Opinionated defaults

- DNS hostnames + DNS support always enabled
- Flow logs to CloudWatch always enabled (override with `enable_flow_logs = false`)
- One NAT gateway per AZ (override with `single_nat_gateway = true` to save money in dev)
- TGW attachments use dedicated `/28` subnets, not regular private subnets

## Example

```hcl
module "vpc" {
  source = "git::https://github.com/<org>/acme-terraform-modules.git//modules/vpc?ref=v0.1.0"

  name             = "dev-app"
  cidr             = "10.10.0.0/16"
  azs              = ["us-east-1a", "us-east-1b"]
  public_subnets   = ["10.10.0.0/24", "10.10.1.0/24"]
  private_subnets  = ["10.10.10.0/24", "10.10.11.0/24"]
  tgw_subnets      = ["10.10.255.0/28", "10.10.255.16/28"]

  tgw_id           = "tgw-0abc123"
  tgw_destinations = ["10.0.0.0/8"]

  single_nat_gateway = true   # cheap dev
}
```
````