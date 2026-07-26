variable "monitor_workspace_name" {
  type        = string
  description = "Azure Monitor Workspace Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "enable_grafana" {
  type        = bool
  description = "Provision Managed Grafana Instance"
  default     = true
}

variable "grafana_public_access" {
  type        = bool
  description = "Enable public access to Grafana instance"
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
