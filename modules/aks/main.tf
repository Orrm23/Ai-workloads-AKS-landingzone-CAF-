# Azure Kubernetes Service (AKS) Parent Engine Module
# Enterprise Production-Ready Private AKS Cluster configured for AI/ML Workloads, GPU Pools, Azure CNI Overlay, and Zero-Trust Governance

resource "azurerm_kubernetes_cluster" "this" {
  name                    = var.cluster_name
  location                = var.location
  resource_group_name     = var.resource_group_name
  dns_prefix              = var.private_cluster_enabled ? null : "${var.cluster_name}-dns"
  dns_prefix_private_cluster = var.private_cluster_enabled ? "${var.cluster_name}-pvtdns" : null
  private_cluster_enabled = var.private_cluster_enabled
  private_dns_zone_id     = var.private_dns_zone_id
  sku_tier                = var.sku_tier

  oidc_issuer_enabled       = true
  workload_identity_enabled = true
  azure_policy_enabled      = true
  image_cleaner_enabled     = true
  image_cleaner_interval_hours = 48

  default_node_pool {
    name                = "system"
    node_count          = var.system_node_pool.node_count
    vm_size             = var.system_node_pool.vm_size
    vnet_subnet_id      = var.subnet_id
    enable_auto_scaling = true
    min_count           = var.system_node_pool.min_count
    max_count           = var.system_node_pool.max_count
    os_disk_size_gb     = var.system_node_pool.os_disk_size_gb
    os_disk_type        = "Ephemeral"
    zones               = ["1", "2", "3"]
    only_critical_addons_enabled = true

    node_labels = {
      "nodepool-type" = "system"
      "environment"   = var.environment
    }

    tags = var.tags
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [var.user_assigned_identity_id]
  }

  kubelet_identity {
    client_id                 = var.kubelet_identity.client_id
    object_id                 = var.kubelet_identity.object_id
    user_assigned_identity_id = var.kubelet_identity.user_assigned_identity_id
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "azure"
    dns_service_ip      = var.dns_service_ip
    service_cidr        = var.service_cidr
    outbound_type       = var.outbound_type
  }

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  microsoft_defender {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  key_vault_secrets_provider {
    secret_rotation_enabled  = true
    secret_rotation_interval = "2m"
  }

  auto_scaler_profile {
    balance_similar_node_groups      = true
    max_graceful_termination_sec     = 600
    scale_down_delay_after_add       = "10m"
    scale_down_unneeded              = "10m"
    scale_down_utilization_threshold = "0.5"
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [tags["DeployedAt"]]
  }
}

# Standard CPU User Node Pool
resource "azurerm_kubernetes_cluster_node_pool" "user" {
  count                 = var.enable_user_node_pool ? 1 : 0
  name                  = "userpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size               = var.user_node_pool.vm_size
  enable_auto_scaling   = true
  min_count             = var.user_node_pool.min_count
  max_count             = var.user_node_pool.max_count
  vnet_subnet_id        = var.subnet_id
  zones                 = ["1", "2", "3"]
  os_disk_size_gb       = 128
  os_type               = "Linux"

  node_labels = {
    "workload"    = "standard"
    "environment" = var.environment
  }

  tags = var.tags
}

# High-Performance GPU Node Pool for AI Model Training and LLM Inference
resource "azurerm_kubernetes_cluster_node_pool" "gpu" {
  count                 = var.enable_gpu_node_pool ? 1 : 0
  name                  = "gpunode"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size               = var.gpu_node_pool.vm_size
  enable_auto_scaling   = true
  min_count             = var.gpu_node_pool.min_count
  max_count             = var.gpu_node_pool.max_count
  vnet_subnet_id        = var.subnet_id
  zones                 = ["1"]
  os_disk_size_gb       = 256
  os_type               = "Linux"

  node_labels = {
    "accelerator" = "nvidia-gpu"
    "workload"    = "ai-inference-training"
    "environment" = var.environment
  }

  node_taints = [
    "sku=gpu:NoSchedule"
  ]

  tags = var.tags
}

# Spot Node Pool for FinOps Cost Optimization on Stateless Processing
resource "azurerm_kubernetes_cluster_node_pool" "spot" {
  count                 = var.enable_spot_node_pool ? 1 : 0
  name                  = "spotpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size               = var.spot_node_pool.vm_size
  priority              = "Spot"
  eviction_policy        = "Delete"
  spot_max_price        = -1 # Pay up to on-demand price
  enable_auto_scaling   = true
  min_count             = var.spot_node_pool.min_count
  max_count             = var.spot_node_pool.max_count
  vnet_subnet_id        = var.subnet_id
  zones                 = ["1", "2", "3"]

  node_labels = {
    "kubernetes.azure.com/scalesetpriority" = "spot"
    "workload"                               = "batch-processing"
  }

  node_taints = [
    "kubernetes.azure.com/scalesetpriority=spot:NoSchedule"
  ]

  tags = var.tags
}

output "id" {
  description = "AKS Cluster Resource ID"
  value       = azurerm_kubernetes_cluster.this.id
}

output "name" {
  description = "AKS Cluster Name"
  value       = azurerm_kubernetes_cluster.this.name
}

output "oidc_issuer_url" {
  description = "AKS OIDC Issuer URL for Workload Identity Federation"
  value       = azurerm_kubernetes_cluster.this.oidc_issuer_url
}

output "kubelet_identity_object_id" {
  description = "Kubelet Identity Object ID for ACR Pull Role Assignment"
  value       = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}

output "key_vault_secrets_provider_identity_client_id" {
  description = "Key Vault CSI Secrets Provider Identity Client ID"
  value       = azurerm_kubernetes_cluster.this.key_vault_secrets_provider[0].secret_identity[0].client_id
}
