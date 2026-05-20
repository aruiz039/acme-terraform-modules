````markdown
# Acme Terraform Modules

Reusable Terraform modules for the Acme platform.

## Available Modules

| Module | Purpose | Latest |
|---|---|---|
| [vpc](./modules/vpc) | Multi-AZ VPC with optional TGW attachment | v0.1.0 |
| [tgw-attachment](./modules/tgw-attachment) | TGW attachment with route table associations | v0.1.0 |
| [iam-role](./modules/iam-role) | IAM role with trust policy and policies | v0.1.0 |
| [permission-set](./modules/permission-set) | IAM IC permission set | v0.1.0 |
| [security-group](./modules/security-group) | Structured-input security group | v0.1.0 |
| [cloudflare-zone](./modules/cloudflare-zone) | Cloudflare DNS zone with records and WAF | v0.1.0 |

## Usage

```hcl
module "vpc" {
  source = "git::https://github.com/<your-org>/acme-terraform-modules.git//modules/vpc?ref=v0.1.0"

  name             = "dev-app"
  cidr             = "10.10.0.0/16"
  azs              = ["us-east-1a", "us-east-1b"]
  public_subnets   = ["10.10.0.0/24", "10.10.1.0/24"]
  private_subnets  = ["10.10.10.0/24", "10.10.11.0/24"]
}
```

## Versioning

Semantic versioning (SemVer). Breaking changes bump major. New features bump minor. Bug fixes bump patch.

## Contributing

PR with module changes + bump version in `CHANGELOG.md`. Tag after merge.
````