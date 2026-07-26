variable "name" {
  type        = string
  description = "Private Endpoint Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "subnet_id" {
  type        = string
  description = "Target Subnet ID where Private Endpoint will reside"
}

variable "target_resource_id" {
  type        = string
  description = "Azure PaaS Resource ID to connect"
}

variable "subresource_names" {
  type        = list(string)
  description = "Target subresource names (e.g. ['vault'], ['registry'], ['account'], ['blob'], ['account'])"
}

variable "private_dns_zone_ids" {
  type        = list(string)
  description = "Optional Private DNS Zone IDs for automatic DNS record creation"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
