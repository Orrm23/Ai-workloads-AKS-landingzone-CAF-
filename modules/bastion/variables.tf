variable "bastion_name" {
  type        = string
  description = "Bastion Host Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "bastion_subnet_id" {
  type        = string
  description = "AzureBastionSubnet ID"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
