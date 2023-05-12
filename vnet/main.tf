# ************************************************
# VNET Information
# ************************************************

resource "azurerm_virtual_network" "vnet" {
  name                = lower("${var.opu_code}-${var.vnet_region_code}-pd-01-vnet")
  location            = lower(var.vnet_region)
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
  dns_servers         = var.vnet_dns_servers
  tags                = var.tags
}

# ************************************************
# VNET Output
# ************************************************

output "vnet_name" {
  value       = azurerm_virtual_network.vnet.name
  description = "The name of the VNET"
}

output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "The ID of the VNET"
}
