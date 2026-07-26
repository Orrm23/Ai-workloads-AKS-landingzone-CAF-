variable "vnet_name" {
  type        = string
  description = "Name of the Virtual Network"
}

variable "location" {
  type        = string
  description = "Azure Region for deployment"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group where VNet resides"
}

variable "address_space" {
  type        = list(string)
  description = "List of address prefixes for the Virtual Network (e.g. ['10.100.0.0/16'])"
}

variable "dns_servers" {
  type        = list(string)
  description = "Custom DNS servers (e.g. Azure Firewall IP or Domain Controllers)"
  default     = []
}

variable "ddos_protection_plan_id" {
  type        = string
  description = "Optional Azure DDoS Network Protection plan ID"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
