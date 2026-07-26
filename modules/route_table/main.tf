# Route Table Child Module
# Controls egress traffic flow (forced tunneling via Azure Firewall)

resource "azurerm_route_table" "this" {
  name                          = var.route_table_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  bgp_route_propagation_enabled = var.bgp_route_propagation_enabled
  tags                          = var.tags

  dynamic "route" {
    for_each = var.routes
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = lookup(route.value, "next_hop_in_ip_address", null)
    }
  }
}

output "id" {
  description = "Route Table Resource ID"
  value       = azurerm_route_table.this.id
}

output "name" {
  description = "Route Table Name"
  value       = azurerm_route_table.this.name
}
