# Azure Firewall Premium Module
# Deploys Azure Firewall Premium with IDPS, Threat Intelligence, and Policy Rules in Hub Network

resource "azurerm_public_ip" "this" {
  name                = "pip-${var.firewall_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
  tags                = var.tags
}

resource "azurerm_firewall_policy" "this" {
  name                     = "afwp-${var.firewall_name}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku                      = var.sku_tier
  threat_intelligence_mode = "Alert"

  identity {
    type = "SystemAssigned"
  }

  dynamic "intrusion_detection" {
    for_each = var.sku_tier == "Premium" ? [1] : []
    content {
      mode = "Enforce"
    }
  }

  tags = var.tags
}

resource "azurerm_firewall" "this" {
  name                = var.firewall_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = var.sku_tier
  firewall_policy_id  = azurerm_firewall_policy.this.id
  zones               = ["1", "2", "3"]

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.firewall_subnet_id
    public_ip_address_id = azurerm_public_ip.this.id
  }

  tags = var.tags
}

output "id" {
  description = "Azure Firewall ID"
  value       = azurerm_firewall.this.id
}

output "private_ip" {
  description = "Azure Firewall Private IP address for UDR routing"
  value       = azurerm_firewall.this.ip_configuration[0].private_ip_address
}

output "public_ip" {
  description = "Azure Firewall Public IP address"
  value       = azurerm_public_ip.this.ip_address
}

output "policy_id" {
  description = "Firewall Policy ID"
  value       = azurerm_firewall_policy.this.id
}
