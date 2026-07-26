# Subnet Child Module
# Provides dedicated subnet provisioning with service endpoints, delegations, and NSG associations

resource "azurerm_subnet" "this" {
  name                                          = var.subnet_name
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = var.vnet_name
  address_prefixes                              = var.address_prefixes
  service_endpoints                             = var.service_endpoints
  private_endpoint_network_policies             = var.private_endpoint_network_policies
  private_link_service_network_policies_enabled = var.private_link_service_network_policies_enabled

  dynamic "delegation" {
    for_each = var.delegation_name != null ? [var.delegation_name] : []
    content {
      name = "delegation-${delegation.value}"
      service_delegation {
        name    = var.delegation_service_name
        actions = var.delegation_actions
      }
    }
  }
}

resource "azurerm_network_security_group" "this" {
  count               = var.create_nsg ? 1 : 0
  name                = "nsg-${var.subnet_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "this" {
  count                     = var.create_nsg ? 1 : 0
  subnet_id                 = azurerm_subnet.this.id
  network_security_group_id = azurerm_network_security_group.this[0].id
}

resource "azurerm_subnet_route_table_association" "this" {
  count          = var.route_table_id != null ? 1 : 0
  subnet_id      = azurerm_subnet.this.id
  route_table_id = var.route_table_id
}

output "id" {
  description = "Subnet Resource ID"
  value       = azurerm_subnet.this.id
}

output "name" {
  description = "Subnet Name"
  value       = azurerm_subnet.this.name
}

output "address_prefixes" {
  description = "Subnet Address Prefixes"
  value       = azurerm_subnet.this.address_prefixes
}
