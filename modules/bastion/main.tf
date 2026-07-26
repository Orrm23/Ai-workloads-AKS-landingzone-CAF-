# Azure Bastion Module
# Secure Agentless Administrative Access to VNet Virtual Machines and AKS Private APIs

resource "azurerm_public_ip" "this" {
  name                = "pip-${var.bastion_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_bastion_host" "this" {
  name                = var.bastion_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  tunneling_enabled   = true
  ip_connect_enabled  = true

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.bastion_subnet_id
    public_ip_address_id = azurerm_public_ip.this.id
  }

  tags = var.tags
}

output "id" {
  description = "Bastion Host ID"
  value       = azurerm_bastion_host.this.id
}

output "dns_name" {
  description = "Bastion Host FQDN"
  value       = azurerm_bastion_host.this.dns_name
}
