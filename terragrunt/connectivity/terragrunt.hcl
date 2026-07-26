# Connectivity Hub Layer Terragrunt Configuration
# Deploys Hub Virtual Network, Azure Firewall Premium, Bastion, and Private DNS Zones

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../modules/network"
}

inputs = {
  environment         = "connectivity"
  vnet_name           = "vnet-alz-hub-eus"
  location            = "eastus"
  resource_group_name = "rg-alz-connectivity-eus"
  address_space       = ["10.200.0.0/16"]

  tags = {
    Layer       = "Connectivity-Hub"
    Environment = "Core"
  }
}
