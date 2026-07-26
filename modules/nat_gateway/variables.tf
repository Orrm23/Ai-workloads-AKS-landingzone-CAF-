variable "nat_gateway_name" {
  type        = string
  description = "NAT Gateway Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of Subnet IDs to associate with NAT Gateway"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
