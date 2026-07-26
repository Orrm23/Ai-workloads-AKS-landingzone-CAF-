variable "firewall_name" {
  type        = string
  description = "Azure Firewall Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "firewall_subnet_id" {
  type        = string
  description = "AzureFirewallSubnet ID"
}

variable "sku_tier" {
  type        = string
  description = "Firewall SKU Tier (Standard or Premium)"
  default     = "Premium"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
