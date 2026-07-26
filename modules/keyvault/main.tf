# Azure Key Vault Module
# Zero-Trust Key Vault with RBAC Authorization, Soft-Delete, Purge Protection, and Private Endpoint Integration

resource "azurerm_key_vault" "this" {
  name                       = var.key_vault_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = var.tenant_id
  sku_name                   = var.sku_name
  enable_rbac_authorization  = true
  soft_delete_retention_days = 90
  purge_protection_enabled   = true

  public_network_access_enabled = var.public_network_access_enabled

  network_acls {
    bypass                     = "AzureServices"
    default_action             = "Deny"
    ip_rules                   = var.allowed_ip_rules
    virtual_network_subnet_ids = var.allowed_subnet_ids
  }

  tags = var.tags
}

output "id" {
  description = "Key Vault Resource ID"
  value       = azurerm_key_vault.this.id
}

output "vault_uri" {
  description = "Key Vault URI"
  value       = azurerm_key_vault.this.vault_uri
}

output "name" {
  description = "Key Vault Name"
  value       = azurerm_key_vault.this.name
}
