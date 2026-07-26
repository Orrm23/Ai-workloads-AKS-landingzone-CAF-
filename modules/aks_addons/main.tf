# AKS Addons Child Module
# Helm/Kubectl deployment of Kubernetes Event-driven Autoscaling (KEDA) and Platform Extensions

resource "azurerm_federated_identity_credential" "workload_identity" {
  for_each            = { for item in var.workload_identities : "${item.name}-${item.namespace}" => item }
  name                = "fic-${each.value.name}-${each.value.namespace}"
  resource_group_name = var.resource_group_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = var.oidc_issuer_url
  parent_id           = each.value.user_assigned_identity_id
  subject             = "system:serviceaccount:${each.value.namespace}:${each.value.service_account_name}"
}

output "federated_credentials" {
  description = "Created OIDC Federated Identity Credentials for Workload Identity"
  value       = [for fic in azurerm_federated_identity_credential.workload_identity : fic.id]
}
