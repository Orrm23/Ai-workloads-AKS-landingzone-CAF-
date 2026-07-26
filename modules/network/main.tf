# Virtual Network Parent Module
# Provides secure enterprise Hub/Spoke Virtual Networks with DDoS protection & diagnostic settings

resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  tags                = var.tags

  dynamic "ddos_protection_plan" {
    for_each = var.ddos_protection_plan_id != null ? [var.ddos_protection_plan_id] : []
    content {
      id     = ddos_protection_plan.value
      enable = true
    }
  }

  lifecycle {
    ignore_changes = [tags["DeployedAt"]]
  }
}

output "id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.this.id
}

output "name" {
  description = "The name of the Virtual Network"
  value       = azurerm_virtual_network.this.name
}

output "address_space" {
  description = "The address space of the Virtual Network"
  value       = azurerm_virtual_network.this.address_space
}
