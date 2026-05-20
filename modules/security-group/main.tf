resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id
  tags        = merge(var.tags, { Name = var.name })

  lifecycle {
    create_before_destroy = true
  }
}

# Flatten ingress rules: one rule per (cidr, sg, prefix list) source
locals {
  ingress_flat = flatten([
    for idx, r in var.ingress_rules : concat(
      [for cidr in r.cidr_blocks : {
        key         = "ingress-${idx}-cidr-${cidr}"
        description = r.description
        from_port   = r.from_port
        to_port     = r.to_port
        protocol    = r.protocol
        type        = "cidr"
        value       = cidr
      }],
      [for sg in r.source_sg_ids : {
        key         = "ingress-${idx}-sg-${sg}"
        description = r.description
        from_port   = r.from_port
        to_port     = r.to_port
        protocol    = r.protocol
        type        = "sg"
        value       = sg
      }],
      [for pl in r.prefix_list_ids : {
        key         = "ingress-${idx}-pl-${pl}"
        description = r.description
        from_port   = r.from_port
        to_port     = r.to_port
        protocol    = r.protocol
        type        = "prefix_list"
        value       = pl
      }],
    )
  ])

  egress_flat = flatten([
    for idx, r in var.egress_rules : concat(
      [for cidr in r.cidr_blocks : {
        key         = "egress-${idx}-cidr-${cidr}"
        description = r.description
        from_port   = r.from_port
        to_port     = r.to_port
        protocol    = r.protocol
        type        = "cidr"
        value       = cidr
      }],
      [for sg in r.source_sg_ids : {
        key         = "egress-${idx}-sg-${sg}"
        description = r.description
        from_port   = r.from_port
        to_port     = r.to_port
        protocol    = r.protocol
        type        = "sg"
        value       = sg
      }],
    )
  ])
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each = { for r in local.ingress_flat : r.key => r }

  security_group_id = aws_security_group.this.id
  description       = each.value.description
  ip_protocol       = each.value.protocol == "-1" ? "-1" : each.value.protocol
  from_port         = each.value.protocol == "-1" ? null : each.value.from_port
  to_port           = each.value.protocol == "-1" ? null : each.value.to_port

  cidr_ipv4                    = each.value.type == "cidr" ? each.value.value : null
  referenced_security_group_id = each.value.type == "sg" ? each.value.value : null
  prefix_list_id               = each.value.type == "prefix_list" ? each.value.value : null

  tags = merge(var.tags, { Name = each.key })
}

resource "aws_vpc_security_group_egress_rule" "this" {
  for_each = { for r in local.egress_flat : r.key => r }

  security_group_id = aws_security_group.this.id
  description       = each.value.description
  ip_protocol       = each.value.protocol == "-1" ? "-1" : each.value.protocol
  from_port         = each.value.protocol == "-1" ? null : each.value.from_port
  to_port           = each.value.protocol == "-1" ? null : each.value.to_port

  cidr_ipv4                    = each.value.type == "cidr" ? each.value.value : null
  referenced_security_group_id = each.value.type == "sg" ? each.value.value : null

  tags = merge(var.tags, { Name = each.key })
}