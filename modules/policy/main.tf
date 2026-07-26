# Azure Policy Governance & Compliance Module
# Assigns built-in security initiatives (CIS Benchmark, Azure Security Benchmark, AKS Hardening)

resource "azurerm_subscription_policy_assignment" "aks_security_baseline" {
  name                 = "aks-pod-security-baseline"
  subscription_id      = var.subscription_id
  policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/a86401ed-ab4e-4a1e-a840-61b795a70a9d" # Kubernetes cluster pod security baseline
  description          = "Enforces Pod Security Baseline rules on all AKS clusters in the subscription"
  display_name         = "Kubernetes cluster pod security baseline standards for Linux-based workloads"

  identity {
    type = "SystemAssigned"
  }

  location = var.location
}

output "assignment_id" {
  description = "Policy Assignment Resource ID"
  value       = azurerm_subscription_policy_assignment.aks_security_baseline.id
}
