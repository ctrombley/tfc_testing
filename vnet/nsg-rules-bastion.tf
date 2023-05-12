# ************************************************
# Network Security Group Rules Resource Reference
# ************************************************
resource "azurerm_network_security_rule" "nsg_bastion_a" {
  count                       = var.vnet_create_bastion == true ? 1 : 0
  name                        = "Allow-Int-In-443"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = [443]
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg_bastion[0].name
}
resource "azurerm_network_security_rule" "nsg_bastion_b" {
  count                       = var.vnet_create_bastion == true ? 1 : 0
  name                        = "Allow-GW-In-443"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = [443]
  source_address_prefix       = "GatewayManager"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg_bastion[0].name
}
resource "azurerm_network_security_rule" "nsg_bastion_c" {
  count                       = var.vnet_create_bastion == true ? 1 : 0
  name                        = "Allow-Out-443"
  priority                    = 120
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = [443]
  source_address_prefix       = "*"
  destination_address_prefix  = "AzureCloud"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg_bastion[0].name
}
resource "azurerm_network_security_rule" "nsg_bastion-d" {
  count                       = var.vnet_create_bastion == true ? 1 : 0
  name                        = "Allow-out-3389-22"
  priority                    = 130
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = [22, 3389]
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg_bastion[0].name
}
