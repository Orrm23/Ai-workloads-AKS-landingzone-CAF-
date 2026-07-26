# Defender for Cloud Module
# Enterprise Continuous Threat Protection for Kubernetes Clusters, Key Vaults, and Containers

resource "azurerm_security_center_subscription_pricing" "containers" {
  tier          = "Standard"
  resource_type = "Containers"
}

resource "azurerm_security_center_subscription_pricing" "keyvaults" {
  tier          = "Standard"
  resource_type = "KeyVaults"
}

resource "azurerm_security_center_subscription_pricing" "storage" {
  tier          = "Standard"
  resource_type = "StorageAccounts"
}

output "status" {
  description = "Status of Defender for Cloud Plans"
  value       = "Defender for Containers, KeyVaults, and Storage enabled."
}
