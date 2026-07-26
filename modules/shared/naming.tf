# Azure Cloud Adoption Framework (CAF) Enterprise Naming Module
# Standardized resource naming conventions for all Azure resources

locals {
  name_prefix = "${var.prefix}-${var.environment}-${var.location_short}"
  
  # CAF Abbreviation Standard Map
  caf_abbreviations = {
    resource_group          = "rg"
    virtual_network         = "vnet"
    subnet                  = "snet"
    network_security_group  = "nsg"
    route_table             = "rt"
    network_interface       = "nic"
    public_ip               = "pip"
    nat_gateway             = "ngw"
    azure_firewall          = "afw"
    firewall_policy         = "afwp"
    bastion_host            = "bas"
    key_vault               = "kv"
    container_registry      = "acr"
    log_analytics_workspace = "log"
    application_insights    = "appi"
    storage_account         = "st"
    kubernetes_cluster      = "aks"
    user_assigned_identity  = "id"
    private_endpoint        = "pe"
    private_dns_zone        = "pdnsz"
    cognitive_account       = "cog"
    machine_learning_workspace = "mlw"
    redis_cache             = "redis"
  }
}

variable "prefix" {
  type        = string
  description = "Organization prefix (e.g. alz, corp, cnp)"
  default     = "alz"
}

variable "environment" {
  type        = string
  description = "Target deployment environment (dev, test, uat, prod, management, connectivity)"
}

variable "location_short" {
  type        = string
  description = "Short location identifier (e.g. eus, wus2, weu, sea)"
  default     = "eus"
}

variable "workload_name" {
  type        = string
  description = "Name of the workload or service"
  default     = "ai"
}

output "resource_names" {
  description = "Constructed CAF-compliant names for standard Azure resources"
  value = {
    resource_group          = "${local.caf_abbreviations.resource_group}-${var.prefix}-${var.workload_name}-${var.environment}-${var.location_short}"
    virtual_network         = "${local.caf_abbreviations.virtual_network}-${var.prefix}-${var.workload_name}-${var.environment}-${var.location_short}"
    aks_cluster             = "${local.caf_abbreviations.kubernetes_cluster}-${var.prefix}-${var.workload_name}-${var.environment}-${var.location_short}"
    key_vault               = "${local.caf_abbreviations.key_vault}${var.prefix}${var.workload_name}${var.environment}${var.location_short}"
    container_registry      = "${local.caf_abbreviations.container_registry}${var.prefix}${var.workload_name}${var.environment}${var.location_short}"
    log_analytics_workspace = "${local.caf_abbreviations.log_analytics_workspace}-${var.prefix}-${var.workload_name}-${var.environment}-${var.location_short}"
    storage_account         = "${local.caf_abbreviations.storage_account}${var.prefix}${var.workload_name}${var.environment}${var.location_short}"
    azure_firewall          = "${local.caf_abbreviations.azure_firewall}-${var.prefix}-hub-${var.location_short}"
    bastion_host            = "${local.caf_abbreviations.bastion_host}-${var.prefix}-hub-${var.location_short}"
  }
}
