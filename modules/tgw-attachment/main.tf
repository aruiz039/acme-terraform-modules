resource "aws_ec2_transit_gateway_route_table_association" "this" {
  transit_gateway_attachment_id  = var.attachment_id
  transit_gateway_route_table_id = var.associated_route_table_id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "this" {
  for_each = toset(var.propagated_route_table_ids)

  transit_gateway_attachment_id  = var.attachment_id
  transit_gateway_route_table_id = each.value
}