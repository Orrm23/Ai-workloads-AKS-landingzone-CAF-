# Production Mission-Critical AI/AKS Spoke Environment Terragrunt Configuration
# Deploys High-Availability Multi-AZ Private AKS Cluster, Multi-GPU Pools, Azure AI Foundry, and Zero-Trust Enterprise Controls

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../modules/aks"
}

inputs = {
  environment         = "prod"
  cluster_name        = "aks-alz-ai-prod-eus"
  location            = "eastus"
  resource_group_name = "rg-alz-ai-prod-eus"
  sku_tier            = "Premium"

  system_node_pool = {
    vm_size         = "Standard_D8s_v5"
    node_count      = 3
    min_count       = 3
    max_count       = 10
    os_disk_size_gb = 256
  }

  enable_user_node_pool = true
  user_node_pool = {
    vm_size   = "Standard_D16s_v5"
    min_count = 3
    max_count = 20
  }

  enable_gpu_node_pool = true
  gpu_node_pool = {
    vm_size   = "Standard_NV36ads_A10_v5"
    min_count = 2
    max_count = 8
  }

  enable_spot_node_pool = false

  tags = {
    Environment        = "Production"
    Workload           = "Mission-Critical-AI"
    SLA                = "99.99%"
    DataClassification = "Strictly-Confidential"
  }
}
