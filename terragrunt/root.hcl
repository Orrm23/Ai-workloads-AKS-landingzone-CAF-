# Terragrunt Root Configuration
# Handles DRY Remote Backend state management, Provider generation, and Enterprise Global Variables

locals {
  # Load environment specific variables if available
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl", "${get_terragrunt_dir()}/env.hcl"), { locals = {} })

  prefix         = "alz"
  location       = "eastus"
  location_short = "eus"
  tenant_id      = get_env("ARM_TENANT_ID", "00000000-0000-0000-0000-000000000000")
  subscription_id= get_env("ARM_SUBSCRIPTION_ID", "00000000-0000-0000-0000-000000000000")

  common_tags = {
    Organization       = "Enterprise Cloud Architecture"
    Architecture       = "Azure Enterprise Scale Landing Zone"
    Framework          = "Microsoft CAF & WAF"
    ProvisionedBy      = "Terragrunt"
    SecurityCompliance = "Zero Trust / CIS / ISO27001"
  }
}

# Generate AzureRM Provider Configuration
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_version = ">= 1.13.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.20.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.1.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
    key_vault {
      purge_soft_delete_on_destroy    = false
      recover_soft_deleted_key_vaults = true
    }
  }
  subscription_id = "${local.subscription_id}"
}
EOF
}

# Configure Remote Storage State Locking
remote_state {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-${local.prefix}-tfstate-eus"
    storage_account_name = "${local.prefix}tfstate${local.location_short}"
    container_name       = "tfstate"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    subscription_id      = local.subscription_id
    tenant_id            = local.tenant_id
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = merge(
  local.common_tags,
  {
    prefix         = local.prefix
    location       = local.location
    location_short = local.location_short
    tenant_id      = local.tenant_id
    subscription_id= local.subscription_id
  }
)
