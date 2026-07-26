variable "workspace_name" {
  type        = string
  description = "Log Analytics Workspace Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "retention_in_days" {
  type        = number
  description = "Data retention days (30 - 730)"
  default     = 90
}

variable "internet_ingestion_enabled" {
  type        = bool
  description = "Enable ingestion over public internet"
  default     = true
}

variable "internet_query_enabled" {
  type        = bool
  description = "Enable query over public internet"
  default     = true
}

variable "enable_app_insights" {
  type        = bool
  description = "Create associated Application Insights resource"
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
