variable "openai_account_name" {
  type        = string
  description = "Azure OpenAI Account Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Enable public network access"
  default     = false
}

variable "deploy_gpt4o" {
  type        = bool
  description = "Deploy GPT-4o model"
  default     = true
}

variable "gpt4o_capacity" {
  type        = number
  description = "Provisioned TPM Capacity for GPT-4o"
  default     = 30
}

variable "deploy_embeddings" {
  type        = bool
  description = "Deploy Text Embedding 3 Large model"
  default     = true
}

variable "enable_aml_workspace" {
  type        = bool
  description = "Enable Azure Machine Learning Workspace"
  default     = true
}

variable "application_insights_id" {
  type        = string
  description = "Application Insights Resource ID for AML Workspace"
  default     = null
}

variable "key_vault_id" {
  type        = string
  description = "Key Vault Resource ID for AML Workspace"
  default     = null
}

variable "storage_account_id" {
  type        = string
  description = "Storage Account Resource ID for AML Workspace"
  default     = null
}

variable "container_registry_id" {
  type        = string
  description = "Container Registry Resource ID for AML Workspace"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
