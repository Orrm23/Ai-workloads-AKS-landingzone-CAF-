variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "oidc_issuer_url" {
  type        = string
  description = "AKS OIDC Issuer URL"
}

variable "workload_identities" {
  type = list(object({
    name                      = string
    namespace                 = string
    service_account_name      = string
    user_assigned_identity_id = string
  }))
  description = "List of Workload Identity Federated Credential mappings"
  default     = []
}
