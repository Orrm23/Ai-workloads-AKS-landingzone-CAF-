variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "dns_zone_names" {
  type        = list(string)
  description = "List of Private DNS Zone names (e.g. ['privatelink.vaultcore.azure.net', 'privatelink.azurecr.io', 'privatelink.openai.azure.com'])"
}

variable "vnet_links" {
  type        = map(string)
  description = "Map of Virtual Network keys to VNet Resource IDs to link"
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
