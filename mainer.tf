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

resource "time_sleep" "wait_30_seconds" {
  create_duration = "30s"
}

resource "azurerm_resource_group" "vnet" {
  depends_on = [time_sleep.wait_30_seconds]

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
  count = 100 

  name                        = "Deny-VNet-out ${count.index}"
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

resource "azurerm_network_interface" "main" {
  count = 100 

  name                = "$test-nic-${count.index}"
  location            = azurerm_resource_group.vnet.location
  resource_group_name = azurerm_resource_group.vnet.name

  ip_configuration {
    name                          = "testconfiguration${count.index}"
    subnet_id                     = azurerm_subnet.pub.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_virtual_machine" "main" {
  count = 100 

  name                  = "test-vm-${count.index}"
  location              = azurerm_resource_group.vnet.location
  resource_group_name   = azurerm_resource_group.vnet.name
  network_interface_ids = [azurerm_network_interface.main[count.index].id]
  vm_size               = "Standard_DS1_v2"
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}
