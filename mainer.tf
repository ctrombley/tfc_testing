terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  tags = { Name = "drift-test" }
  location = "southcentralus"
}

module "subnet_addrs" {
  source = "hashicorp/subnets/cidr"

  base_cidr_block = "10.0.0.0/8"
  networks = [
    {
      name     = "pub"
      new_bits = 4
    },
  ]
}

resource "azurerm_resource_group" "vnet" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "test-vnet"
  location            = local.location
  resource_group_name = azurerm_resource_group.vnet.name
  address_space       = ["10.0.0.0/8"]
  dns_servers         = ["10.0.0.4"]
  tags                = local.tags
}

resource "azurerm_subnet" "pub" {
  name                                           = "test-pub-snet"
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  resource_group_name                            = azurerm_resource_group.vnet.name
  address_prefixes                               = [module.subnet_addrs.network_cidr_blocks["pub"]]
  service_endpoints                              = []
  enforce_private_link_endpoint_network_policies = false
}
resource "azurerm_network_security_group" "pub" {
  name                = "test-pub"
  location            = local.location
  resource_group_name = azurerm_resource_group.vnet.name
  tags                = local.tags
}

resource "azurerm_network_security_rule" "pub_deny" {
  name                        = "Deny-VNet-out"
  priority                    = 4000
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = azurerm_resource_group.vnet.name
  network_security_group_name = azurerm_network_security_group.pub.name
}

resource "azurerm_subnet_network_security_group_association" "pub" {
  subnet_id                 = azurerm_subnet.pub.id
  network_security_group_id = azurerm_network_security_group.pub.id
}
