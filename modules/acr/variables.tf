variable "acr_name" {
  type        = string
  description = "ACR Name (alphanumeric only)"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "sku" {
  type        = string
  description = "ACR SKU Tier (Standard or Premium)"
  default     = "Premium"
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Enable public network access"
  default     = false
}

variable "zone_redundancy_enabled" {
  type        = bool
  description = "Enable zone redundancy"
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
