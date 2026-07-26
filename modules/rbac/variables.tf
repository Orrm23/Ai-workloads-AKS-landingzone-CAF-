variable "role_assignments" {
  type = list(object({
    scope                = string
    role_definition_name = string
    principal_id         = string
  }))
  description = "List of RBAC assignments to apply"
  default     = []
}
