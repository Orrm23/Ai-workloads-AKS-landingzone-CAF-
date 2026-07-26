variable "cluster_name" {
  type        = string
  description = "AKS Cluster Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "environment" {
  type        = string
  description = "Deployment Environment"
}

variable "subnet_id" {
  type        = string
  description = "AKS Node Subnet Resource ID"
}

variable "sku_tier" {
  type        = string
  description = "AKS SLA Tier (Free, Standard, Premium)"
  default     = "Standard"
}

variable "private_cluster_enabled" {
  type        = bool
  description = "Enforce Private API Server Access"
  default     = true
}

variable "private_dns_zone_id" {
  type        = string
  description = "Optional Private DNS Zone ID for private API server FQDN"
  default     = "System"
}

variable "user_assigned_identity_id" {
  type        = string
  description = "User Assigned Managed Identity Resource ID for AKS Control Plane"
}

variable "kubelet_identity" {
  type = object({
    client_id                 = string
    object_id                 = string
    user_assigned_identity_id = string
  })
  description = "Managed Kubelet Identity details"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "Log Analytics Workspace ID for Container Insights"
}

variable "service_cidr" {
  type        = string
  description = "Kubernetes Service CIDR range"
  default     = "172.20.0.0/16"
}

variable "dns_service_ip" {
  type        = string
  description = "Kubernetes CoreDNS IP (Must be within service_cidr)"
  default     = "172.20.0.10"
}

variable "outbound_type" {
  type        = string
  description = "Egress routing method (userDefinedRouting, loadBalancer, natGateway)"
  default     = "userDefinedRouting"
}

variable "system_node_pool" {
  type = object({
    vm_size         = string
    node_count      = number
    min_count       = number
    max_count       = number
    os_disk_size_gb = number
  })
  description = "System Node Pool Configuration"
  default = {
    vm_size         = "Standard_D4s_v5"
    node_count      = 3
    min_count       = 3
    max_count       = 6
    os_disk_size_gb = 128
  }
}

variable "enable_user_node_pool" {
  type        = bool
  description = "Enable standard user node pool"
  default     = true
}

variable "user_node_pool" {
  type = object({
    vm_size   = string
    min_count = number
    max_count = number
  })
  description = "User Node Pool Configuration"
  default = {
    vm_size   = "Standard_D8s_v5"
    min_count = 2
    max_count = 10
  }
}

variable "enable_gpu_node_pool" {
  type        = bool
  description = "Enable GPU node pool for AI/ML inference and fine-tuning"
  default     = true
}

variable "gpu_node_pool" {
  type = object({
    vm_size   = string
    min_count = number
    max_count = number
  })
  description = "GPU Node Pool Configuration"
  default = {
    vm_size   = "Standard_NC6s_v3"
    min_count = 1
    max_count = 4
  }
}

variable "enable_spot_node_pool" {
  type        = bool
  description = "Enable Spot Node Pool for batch processing FinOps savings"
  default     = true
}

variable "spot_node_pool" {
  type = object({
    vm_size   = string
    min_count = number
    max_count = number
  })
  description = "Spot Node Pool Configuration"
  default = {
    vm_size   = "Standard_D4s_v5"
    min_count = 0
    max_count = 10
  }
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
