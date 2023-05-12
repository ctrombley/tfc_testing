# ************************************************
# Network Security Group Rules Resource Reference
# ************************************************
resource "azurerm_network_security_rule" "nsg_pub_a" {
  name                        = "Deny-VNet-out"
  priority                    = 4000
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg_pub.name
}