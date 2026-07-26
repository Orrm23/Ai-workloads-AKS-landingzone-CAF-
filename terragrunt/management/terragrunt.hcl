# Management Platform Layer Terragrunt Configuration
# Deploys Centralized Log Analytics, Azure Monitor Workspace, Managed Grafana, and Policy Governance

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../modules/log_analytics"
}

inputs = {
  environment         = "management"
  workspace_name      = "log-alz-mgmt-eus"
  location            = "eastus"
  resource_group_name = "rg-alz-management-eus"
  retention_in_days   = 90
  enable_app_insights = true

  tags = {
    Layer       = "Management-Operations"
    Environment = "Core"
  }
}
