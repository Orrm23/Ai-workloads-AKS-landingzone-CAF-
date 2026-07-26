# Azure Monitor Workspace & Managed Grafana Module
# Native Prometheus metric collection and dashboard visualization for Kubernetes & AI workloads

resource "azurerm_monitor_workspace" "this" {
  name                = var.monitor_workspace_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

resource "azurerm_dashboard_grafana" "this" {
  count               = var.enable_grafana ? 1 : 0
  name                = "graf-${var.monitor_workspace_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  public_network_access_enabled = var.grafana_public_access

  identity {
    type = "SystemAssigned"
  }

  azure_monitor_workspace_integrations {
    resource_id = azurerm_monitor_workspace.this.id
  }

  tags = var.tags
}

output "workspace_id" {
  description = "Azure Monitor Workspace ID"
  value       = azurerm_monitor_workspace.this.id
}

output "grafana_id" {
  description = "Managed Grafana Instance ID"
  value       = var.enable_grafana ? azurerm_dashboard_grafana.this[0].id : null
}

output "grafana_endpoint" {
  description = "Managed Grafana Endpoint URL"
  value       = var.enable_grafana ? azurerm_dashboard_grafana.this[0].endpoint : null
}
