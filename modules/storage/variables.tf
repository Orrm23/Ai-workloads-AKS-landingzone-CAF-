variable "storage_account_name" {
  type        = string
  description = "Storage Account Name (alphanumeric only, max 24 chars)"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "account_tier" {
  type        = string
  description = "Storage Account Tier (Standard or Premium)"
  default     = "Standard"
}

variable "replication_type" {
  type        = string
  description = "Replication Strategy (LRS, ZRS, GRS)"
  default     = "ZRS"
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Enable public network access"
  default     = false
}

variable "allowed_ip_rules" {
  type        = list(string)
  description = "Allowed IP rules for network ACLs"
  default     = []
}

variable "allowed_subnet_ids" {
  type        = list(string)
  description = "Allowed Subnet IDs for network ACLs"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
