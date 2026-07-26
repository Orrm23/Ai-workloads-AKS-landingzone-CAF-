# Centralized Log Analytics Workspace Module
# Foundation for Container Insights, Azure Monitor, Defender for Cloud, and Audit Logs

resource "azurerm_log_analytics_workspace" "this" {
  name                       = var.workspace_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  sku                        = "PerGB2018"
  retention_in_days          = var.retention_in_days
  internet_ingestion_enabled = var.internet_ingestion_enabled
  internet_query_enabled     = var.internet_query_enabled
  tags                       = var.tags
}

resource "azurerm_application_insights" "this" {
  count               = var.enable_app_insights ? 1 : 0
  name                = "appi-${var.workspace_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  workspace_id        = azurerm_log_analytics_workspace.this.id
  application_type    = "web"
  tags                = var.tags
}

output "id" {
  description = "Log Analytics Workspace Resource ID"
  value       = azurerm_log_analytics_workspace.this.id
}

output "workspace_id" {
  description = "Log Analytics Workspace GUID ID"
  value       = azurerm_log_analytics_workspace.this.workspace_id
}

output "app_insights_instrumentation_key" {
  description = "Application Insights Instrumentation Key"
  value       = var.enable_app_insights ? azurerm_application_insights.this[0].instrumentation_key : null
  sensitive   = true
}

output "app_insights_connection_string" {
  description = "Application Insights Connection String"
  value       = var.enable_app_insights ? azurerm_application_insights.this[0].connection_string : null
  sensitive   = true
}
