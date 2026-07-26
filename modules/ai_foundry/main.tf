# Azure AI Foundry & Machine Learning Module
# Private AI Infrastructure powering Azure OpenAI Service, LLM Deployments, Azure ML, and Prompt Flow

resource "azurerm_cognitive_account" "openai" {
  name                          = var.openai_account_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  kind                          = "OpenAI"
  sku_name                      = "S0"
  public_network_access_enabled = var.public_network_access_enabled
  custom_subdomain_name         = var.openai_account_name

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# Azure OpenAI Model Deployments
resource "azurerm_cognitive_deployment" "gpt4o" {
  count                = var.deploy_gpt4o ? 1 : 0
  name                 = "gpt-4o"
  cognitive_account_id = azurerm_cognitive_account.openai.id

  model {
    format  = "OpenAI"
    name    = "gpt-4o"
    version = "2024-05-13"
  }

  sku {
    name     = "Standard"
    capacity = var.gpt4o_capacity
  }
}

resource "azurerm_cognitive_deployment" "embeddings" {
  count                = var.deploy_embeddings ? 1 : 0
  name                 = "text-embedding-3-large"
  cognitive_account_id = azurerm_cognitive_account.openai.id

  model {
    format  = "OpenAI"
    name    = "text-embedding-3-large"
    version = "1"
  }

  sku {
    name     = "Standard"
    capacity = 30
  }
}

# Azure Machine Learning Workspace for Custom Model Fine-Tuning & Prompt Flow
resource "azurerm_machine_learning_workspace" "this" {
  count                   = var.enable_aml_workspace ? 1 : 0
  name                    = "mlw-${var.openai_account_name}"
  location                = var.location
  resource_group_name     = var.resource_group_name
  application_insights_id = var.application_insights_id
  key_vault_id            = var.key_vault_id
  storage_account_id      = var.storage_account_id
  container_registry_id   = var.container_registry_id
  public_network_access_enabled = var.public_network_access_enabled

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

output "openai_id" {
  description = "Azure OpenAI Account Resource ID"
  value       = azurerm_cognitive_account.openai.id
}

output "openai_endpoint" {
  description = "Azure OpenAI Service Endpoint URL"
  value       = azurerm_cognitive_account.openai.endpoint
}

output "aml_workspace_id" {
  description = "Azure Machine Learning Workspace ID"
  value       = var.enable_aml_workspace ? azurerm_machine_learning_workspace.this[0].id : null
}
