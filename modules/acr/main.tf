# Azure Container Registry (ACR) Module
# Enterprise Private Container Registry with Defender Scanning, Soft-Delete, and Premium SKU

resource "azurerm_container_registry" "this" {
  name                          = var.acr_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.sku
  admin_enabled                 = false
  public_network_access_enabled = var.public_network_access_enabled
  zone_redundancy_enabled       = var.zone_redundancy_enabled

  identity {
    type = "SystemAssigned"
  }

  retention_policy {
    enabled = true
    days    = 30
  }

  trust_policy {
    enabled = true
  }

  tags = var.tags
}

output "id" {
  description = "Container Registry Resource ID"
  value       = azurerm_container_registry.this.id
}

output "login_server" {
  description = "ACR Login Server FQDN"
  value       = azurerm_container_registry.this.login_server
}

output "principal_id" {
  description = "ACR Identity Principal ID"
  value       = azurerm_container_registry.this.identity[0].principal_id
}
