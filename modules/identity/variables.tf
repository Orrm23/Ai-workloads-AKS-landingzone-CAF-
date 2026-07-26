variable "identity_name" {
  type        = string
  description = "Managed Identity Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
