# Private DNS Zone Module
# Enterprise Private DNS Resolution for Private Endpoints (Key Vault, ACR, OpenAI, AKS Private Link)

resource "azurerm_private_dns_zone" "this" {
  for_each            = toset(var.dns_zone_names)
  name                = each.value
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each              = { for pair in local.zone_vnet_pairs : "${pair.zone}-${pair.vnet_key}" => pair }
  name                  = "link-${each.value.vnet_key}-${replace(each.value.zone, ".", "-")}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this[each.value.zone].name
  virtual_network_id    = each.value.vnet_id
  registration_enabled  = false
  tags                  = var.tags
}

locals {
  zone_vnet_pairs = flatten([
    for zone in var.dns_zone_names : [
      for vnet_key, vnet_id in var.vnet_links : {
        zone     = zone
        vnet_key = vnet_key
        vnet_id  = vnet_id
      }
    ]
  ])
}

output "zone_ids" {
  description = "Map of Private DNS Zone names to IDs"
  value       = { for zone in var.dns_zone_names : zone => azurerm_private_dns_zone.this[zone].id }
}

output "zone_names" {
  description = "List of Private DNS Zone names created"
  value       = [for z in azurerm_private_dns_zone.this : z.name]
}
