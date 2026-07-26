variable "subnet_name" {
  type        = string
  description = "Name of the Subnet"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "vnet_name" {
  type        = string
  description = "Virtual network name"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "eastus"
}

variable "address_prefixes" {
  type        = list(string)
  description = "Subnet address range list"
}

variable "service_endpoints" {
  type        = list(string)
  description = "List of service endpoints (e.g., Microsoft.KeyVault, Microsoft.Storage, Microsoft.ContainerRegistry)"
  default     = []
}

variable "private_endpoint_network_policies" {
  type        = string
  description = "Network policies for private endpoints (Enabled/Disabled)"
  default     = "Enabled"
}

variable "private_link_service_network_policies_enabled" {
  type        = bool
  description = "Enable network policies for private link service"
  default     = true
}

variable "create_nsg" {
  type        = bool
  description = "Create and attach NSG to subnet"
  default     = true
}

variable "route_table_id" {
  type        = string
  description = "Optional Route Table ID to attach to subnet"
  default     = null
}

variable "delegation_name" {
  type        = string
  description = "Optional delegation identifier"
  default     = null
}

variable "delegation_service_name" {
  type        = string
  description = "Optional delegated service name (e.g. Microsoft.ContainerInstance/containerGroups)"
  default     = null
}

variable "delegation_actions" {
  type        = list(string)
  description = "Optional list of actions for service delegation"
  default     = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
