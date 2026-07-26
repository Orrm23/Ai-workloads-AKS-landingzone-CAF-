# Enterprise Resource Tagging Standard Module

variable "environment" {
  type        = string
  description = "Deployment environment name"
}

variable "workload_name" {
  type        = string
  description = "Workload name"
  default     = "ai-platform"
}

variable "owner" {
  type        = string
  description = "Platform / Engineering Owner contact"
  default     = "platform-engineering@enterprise.com"
}

variable "cost_center" {
  type        = string
  description = "FinOps Cost Center Code"
  default     = "CC-10948-AI"
}

variable "business_unit" {
  type        = string
  description = "Business Unit"
  default     = "Enterprise AI & Cloud Platform"
}

variable "additional_tags" {
  type        = map(string)
  description = "Custom additional tags"
  default     = {}
}

output "tags" {
  description = "Standardized map of resource tags applied across all deployed infrastructure"
  value = merge(
    {
      Environment        = var.environment
      WorkloadName       = var.workload_name
      Owner              = var.owner
      CostCenter         = var.cost_center
      BusinessUnit       = var.business_unit
      ManagedBy          = "Terraform-Terragrunt"
      Architecture       = "Enterprise-Scale-Landing-Zone"
      SecurityCompliance = "ISO27001-SOC2-HIPAA-NIST"
      DeployedAt         = timestamp()
    },
    var.additional_tags
  )
}
