# UAT AI/AKS Spoke Environment Terragrunt Configuration

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../modules/aks"
}

inputs = {
  environment         = "uat"
  cluster_name        = "aks-alz-ai-uat-eus"
  location            = "eastus"
  resource_group_name = "rg-alz-ai-uat-eus"
  sku_tier            = "Standard"

  system_node_pool = {
    vm_size         = "Standard_D4s_v5"
    node_count      = 3
    min_count       = 3
    max_count       = 6
    os_disk_size_gb = 128
  }

  enable_user_node_pool = true
  enable_gpu_node_pool  = true
  enable_spot_node_pool = false

  tags = {
    Environment = "UAT"
    Workload    = "AI-Staging"
  }
}
