variable "subscription_id" {
  type        = string
  description = "Target Subscription ID for Policy Assignment"
}

variable "location" {
  type        = string
  description = "Azure Region for Policy Identity location"
  default     = "eastus"
}
