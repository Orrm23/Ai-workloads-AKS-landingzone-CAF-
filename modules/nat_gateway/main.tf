# NAT Gateway Module
# Provides secure outbound internet access for private AKS node pools with public IP prefix allocation

resource "azurerm_public_ip" "this" {
  name                = "pip-${var.nat_gateway_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
  tags                = var.tags
}

resource "azurerm_nat_gateway" "this" {
  name                    = var.nat_gateway_name
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
  tags                    = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "this" {
  nat_gateway_id       = azurerm_nat_gateway.this.id
  public_ip_address_id = azurerm_public_ip.this.id
}

resource "azurerm_subnet_nat_gateway_association" "this" {
  for_each       = toset(var.subnet_ids)
  subnet_id      = each.value
  nat_gateway_id = azurerm_nat_gateway.this.id
}

output "id" {
  description = "NAT Gateway ID"
  value       = azurerm_nat_gateway.this.id
}

output "public_ip" {
  description = "NAT Gateway Public IP"
  value       = azurerm_public_ip.this.ip_address
}
