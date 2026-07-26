# Dev AI/AKS Spoke Environment Terragrunt Configuration
# Deploys Isolated Dev Spoke VNet, Private AKS Cluster, ACR, Key Vault, and Azure OpenAI

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../modules/aks"
}

inputs = {
  environment         = "dev"
  cluster_name        = "aks-alz-ai-dev-eus"
  location            = "eastus"
  resource_group_name = "rg-alz-ai-dev-eus"
  sku_tier            = "Standard"

  system_node_pool = {
    vm_size         = "Standard_D4s_v5"
    node_count      = 2
    min_count       = 2
    max_count       = 4
    os_disk_size_gb = 128
  }

  enable_user_node_pool = true
  user_node_pool = {
    vm_size   = "Standard_D4s_v5"
    min_count = 1
    max_count = 5
  }

  enable_gpu_node_pool = true
  gpu_node_pool = {
    vm_size   = "Standard_NC6s_v3"
    min_count = 1
    max_count = 2
  }

  enable_spot_node_pool = true
  spot_node_pool = {
    vm_size   = "Standard_D4s_v5"
    min_count = 0
    max_count = 5
  }

  tags = {
    Environment = "Development"
    Workload    = "AI-Sandbox"
  }
}
