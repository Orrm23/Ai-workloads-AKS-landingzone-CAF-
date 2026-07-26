variable "route_table_name" {
  type        = string
  description = "Route Table Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "bgp_route_propagation_enabled" {
  type        = bool
  description = "Enable BGP route propagation"
  default     = true
}

variable "routes" {
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  description = "List of route rules to attach to the Route Table"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
