# Enterprise Storage Account Module
# Highly secure Azure Storage for AI Datasets, Model Artifacts, and Persistent Volumes

resource "azurerm_storage_account" "this" {
  name                             = var.storage_account_name
  resource_group_name              = var.resource_group_name
  location                         = var.location
  account_tier                     = var.account_tier
  account_replication_type         = var.replication_type
  account_kind                     = "StorageV2"
  cross_tenant_replication_enabled = false
  access_tier                      = "Hot"
  min_tls_version                  = "TLS1_2"
  public_network_access_enabled    = var.public_network_access_enabled
  allow_nested_items_to_be_public  = false

  blob_properties {
    versioning_enabled = true
    delete_retention_policy {
      days = 30
    }
    container_delete_retention_policy {
      days = 30
    }
  }

  network_rules {
    default_action             = "Deny"
    bypass                     = ["AzureServices"]
    ip_rules                   = var.allowed_ip_rules
    virtual_network_subnet_ids = var.allowed_subnet_ids
  }

  tags = var.tags
}

output "id" {
  description = "Storage Account Resource ID"
  value       = azurerm_storage_account.this.id
}

output "name" {
  description = "Storage Account Name"
  value       = azurerm_storage_account.this.name
}

output "primary_blob_endpoint" {
  description = "Primary Blob Endpoint URL"
  value       = azurerm_storage_account.this.primary_blob_endpoint
}
