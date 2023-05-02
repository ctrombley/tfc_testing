# ************************************************
# Network Watcher Information
# ************************************************

resource "azurerm_network_watcher" "network_watcher" {
  count               = var.vnet_create_network_watcher == true ? 1 : 0
  name                = "${var.opu_code}-${var.vnet_region_code}-pd-01-nw"
  location            = var.vnet_region
  tags                = var.tags
  resource_group_name = var.resource_group_name
}

# ************************************************
# Network Watcher Output
# ************************************************

output "network_watcher_name" {
  value       = var.vnet_create_network_watcher == true ? azurerm_network_watcher.network_watcher[0].name : null
  description = "Name of Network Watcher within the VNET"
}

output "network_watcher_id" {
  value       = var.vnet_create_network_watcher == true ? azurerm_network_watcher.network_watcher[0].id : null
  description = "id of Network Watcher within the VNET"
}
