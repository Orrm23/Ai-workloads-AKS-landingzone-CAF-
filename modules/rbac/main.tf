# Azure Role-Based Access Control (RBAC) Module
# Least-privilege role assignments for service principals and managed identities

resource "azurerm_role_assignment" "this" {
  for_each             = { for item in var.role_assignments : "${item.principal_id}-${item.role_definition_name}-${item.scope}" => item }
  scope                = each.value.scope
  role_definition_name = each.value.role_definition_name
  principal_id         = each.value.principal_id
}

output "assignments" {
  description = "Created RBAC Role Assignments"
  value       = [for a in azurerm_role_assignment.this : a.id]
}
