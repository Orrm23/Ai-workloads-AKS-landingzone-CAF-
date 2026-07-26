variable "hub_vnet_name" {
  type        = string
  description = "Hub Virtual Network Name"
}

variable "hub_resource_group_name" {
  type        = string
  description = "Hub Resource Group Name"
}

variable "hub_vnet_id" {
  type        = string
  description = "Hub Virtual Network Resource ID"
}

variable "spoke_vnet_name" {
  type        = string
  description = "Spoke Virtual Network Name"
}

variable "spoke_resource_group_name" {
  type        = string
  description = "Spoke Resource Group Name"
}

variable "spoke_vnet_id" {
  type        = string
  description = "Spoke Virtual Network Resource ID"
}

variable "allow_gateway_transit" {
  type        = bool
  description = "Allow gateway transit from Hub to Spoke"
  default     = false
}

variable "use_remote_gateways" {
  type        = bool
  description = "Use remote gateway in Hub from Spoke"
  default     = false
}
