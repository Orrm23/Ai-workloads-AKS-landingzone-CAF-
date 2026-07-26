variable "key_vault_name" {
  type        = string
  description = "Key Vault Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "tenant_id" {
  type        = string
  description = "Azure Active Directory Tenant ID"
}

variable "sku_name" {
  type        = string
  description = "Key Vault SKU (standard or premium)"
  default     = "premium"
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Enable public network access"
  default     = false
}

variable "allowed_ip_rules" {
  type        = list(string)
  description = "Allowed IP CIDR blocks"
  default     = []
}

variable "allowed_subnet_ids" {
  type        = list(string)
  description = "Allowed Subnet IDs for Network ACLs"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
