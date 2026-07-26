# User-Assigned Managed Identity Module
# Provides identity objects for Azure AD Workload Identity and zero-trust service authentication

resource "azurerm_user_assigned_identity" "this" {
  name                = var.identity_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

output "id" {
  description = "Managed Identity Resource ID"
  value       = azurerm_user_assigned_identity.this.id
}

output "principal_id" {
  description = "Managed Identity Service Principal ID"
  value       = azurerm_user_assigned_identity.this.principal_id
}

output "client_id" {
  description = "Managed Identity Client ID"
  value       = azurerm_user_assigned_identity.this.client_id
}
