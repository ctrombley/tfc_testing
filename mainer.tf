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
  vmsizes = ["Basic_A0","Basic_A1","Basic_A2","Basic_A3","Basic_A4","Standard_A0","Standard_A1","Standard_A1_v2","Standard_A2","Standard_A2_v2","Standard_A2m_v2","Standard_A3","Standard_A4","Standard_A4_v2","Standard_A4m_v2","Standard_A5","Standard_A6","Standard_A7","Standard_A8_v2","Standard_A8m_v2","Standard_B12ms","Standard_B16ms","Standard_B1ls","Standard_B1ms","Standard_B1s","Standard_B20ms","Standard_B2ms","Standard_B2s","Standard_B4ms","Standard_B8ms","Standard_D1","Standard_D1_v2","Standard_D11","Standard_D11_v2","Standard_D12","Standard_D12_v2","Standard_D13","Standard_D14","Standard_D14_v2","Standard_D15_v2","Standard_D16_v3","Standard_D16_v4","Standard_D16_v5","Standard_D16a_v4","Standard_D16ads_v5","Standard_D16as_v4","Standard_D16as_v5","Standard_D16d_v4","Standard_D16d_v5","Standard_D16ds_v4","Standard_D16ds_v5","Standard_D16pds_v5","Standard_D16plds_v5","Standard_D16pls_v5","Standard_D16ps_v5","Standard_D16s_v3","Standard_D16s_v4","Standard_D16s_v5","Standard_D2","Standard_D2_v2","Standard_D2_v3","Standard_D2_v4","Standard_D2_v5","Standard_D2a_v4","Standard_D2ads_v5","Standard_D2as_v4","Standard_D2as_v5","Standard_D2d_v4","Standard_D2d_v5","Standard_D2ds_v4","Standard_D2ds_v5","Standard_D2pds_v5","Standard_D2plds_v5","Standard_D2pls_v5","Standard_D2ps_v5","Standard_D2s_v3","Standard_D2s_v4","Standard_D2s_v5","Standard_D3","Standard_D3_v2","Standard_D32_v3","Standard_D32_v4","Standard_D32_v5","Standard_D32a_v4","Standard_D32ads_v5","Standard_D32as_v4","Standard_D32as_v5","Standard_D32d_v4","Standard_D32d_v5","Standard_D32ds_v4","Standard_D32ds_v5","Standard_D32pds_v5","Standard_D32plds_v5","Standard_D32pls_v5","Standard_D32ps_v5","Standard_D32s_v3","Standard_D32s_v4","Standard_D32s_v5","Standard_D4","Standard_D4_v2","Standard_D4_v3","Standard_D4_v4","Standard_D4_v5","Standard_D48_v3","Standard_D48_v4","Standard_D48_v5","Standard_D48a_v4","Standard_D48ads_v5","Standard_D48as_v4","Standard_D48as_v5","Standard_D48d_v4","Standard_D48d_v5","Standard_D48ds_v4","Standard_D48ds_v5","Standard_D48pds_v5","Standard_D48plds_v5","Standard_D48pls_v5","Standard_D48ps_v5","Standard_D48s_v3","Standard_D48s_v4","Standard_D48s_v5","Standard_D4a_v4","Standard_D4ads_v5","Standard_D4as_v4","Standard_D4as_v5","Standard_D4d_v4","Standard_D4d_v5","Standard_D4ds_v4","Standard_D4ds_v5","Standard_D4pds_v5","Standard_D4plds_v5","Standard_D4pls_v5","Standard_D4ps_v5","Standard_D4s_v3","Standard_D4s_v4","Standard_D4s_v5","Standard_D5_v2","Standard_D64_v3","Standard_D64_v4","Standard_D64_v5","Standard_D64a_v4","Standard_D64ads_v5","Standard_D64as_v4","Standard_D64as_v5","Standard_D64d_v4","Standard_D64d_v5","Standard_D64ds_v4","Standard_D64ds_v5","Standard_D64pds_v5","Standard_D64plds_v5","Standard_D64pls_v5","Standard_D64ps_v5","Standard_D64s_v3","Standard_D64s_v4","Standard_D64s_v5","Standard_D8_v4","Standard_D8_v5","Standard_D8a_v4","Standard_D8ads_v5","Standard_D8as_v4","Standard_D8as_v5","Standard_D8d_v4","Standard_D8d_v5","Standard_D8ds_v4","Standard_D8ds_v5","Standard_D8pds_v5","Standard_D8plds_v5","Standard_D8pls_v5","Standard_D8ps_v5","Standard_D8s_v3","Standard_D8s_v4","Standard_D8s_v5","Standard_D96_v5","Standard_D96a_v4","Standard_D96ads_v5","Standard_D96as_v4","Standard_D96as_v5","Standard_D96d_v5","Standard_D96ds_v5","Standard_D96s_v5","Standard_DC16ads_v5","Standard_DC16as_v5","Standard_DC16ds_v3","Standard_DC16s_v3","Standard_DC1ds_v3","Standard_DC1s_v2","Standard_DC1s_v3","Standard_DC24ds_v3","Standard_DC24s_v3","Standard_DC2ads_v5","Standard_DC2as_v5","Standard_DC2ds_v3","Standard_DC2s","Standard_DC2s_v2","Standard_DC2s_v3","Standard_DC32as_v5","Standard_DC32ds_v3","Standard_DC32s_v3","Standard_DC48ads_v5","Standard_DC48as_v5","Standard_DC48ds_v3","Standard_DC48s_v3","Standard_DC4ads_v5","Standard_DC4as_v5","Standard_DC4ds_v3","Standard_DC4s","Standard_DC4s_v2","Standard_DC64ads_v5","Standard_DC64as_v5","Standard_DC8_v2","Standard_DC8ads_v5","Standard_DC8as_v5","Standard_DC8s_v3","Standard_DC96ads_v5","Standard_DC96as_v5","Standard_DS1","Standard_DS1_v2","Standard_DS11","Standard_DS11_v2","Standard_DS11","Standard_DS12","Standard_DS12_v2","Standard_DS12","Standard_DS12","Standard_DS13","Standard_DS13_v2","Standard_DS13","Standard_DS13","Standard_DS14","Standard_DS14_v2","Standard_DS14","Standard_DS14","Standard_DS15_v2","Standard_DS2","Standard_DS2_v2","Standard_DS3","Standard_DS3_v2","Standard_DS4","Standard_DS4_v2","Standard_DS5_v2","Standard_E104i_v5","Standard_E104id_v5","Standard_E104ids_v5","Standard_E104is_v5","Standard_E112iads_v5","Standard_E112ias_v5","Standard_E16_v3","Standard_E16_v4","Standard_E16_v5","Standard_E16","Standard_E16","Standard_E16","Standard_E16","Standard_E16","Standard_E16","Standard_E16","Standard_E16","Standard_E16","Standard_E16","Standard_E16","Standard_E16","Standard_E16","Standard_E16","Standard_E16","Standard_E16","Standard_E16a_v4","Standard_E16ads_v5","Standard_E16as_v4","Standard_E16as_v5","Standard_E16bds_v5","Standard_E16bs_v5","Standard_E16d_v4","Standard_E16d_v5","Standard_E16ds_v4","Standard_E16ds_v5","Standard_E16pds_v5","Standard_E16ps_v5","Standard_E16s_v3","Standard_E16s_v4","Standard_E16s_v5","Standard_E2_v4","Standard_E2_v5","Standard_E20_v3","Standard_E20_v4","Standard_E20a_v4","Standard_E20ads_v5","Standard_E20as_v4","Standard_E20as_v5","Standard_E20d_v4","Standard_E20d_v5","Standard_E20ds_v4","Standard_E20ds_v5","Standard_E20pds_v5","Standard_E20ps_v5","Standard_E20s_v3","Standard_E20s_v4","Standard_E20s_v5","Standard_E2a_v4","Standard_E2ads_v5","Standard_E2as_v4","Standard_E2as_v5","Standard_E2bds_v5","Standard_E2bs_v5","Standard_E2d_v4","Standard_E2d_v5","Standard_E2ds_v4","Standard_E2ds_v5","Standard_E2pds_v5","Standard_E2ps_v5","Standard_E2s_v3","Standard_E2s_v4","Standard_E2s_v5","Standard_E32_v4","Standard_E32_v5","Standard_E32","Standard_E32","Standard_E32","Standard_E32","Standard_E32","Standard_E32","Standard_E32","Standard_E32","Standard_E32","Standard_E32","Standard_E32","Standard_E32","Standard_E32","Standard_E32","Standard_E32","Standard_E32ads_v5","Standard_E32as_v4","Standard_E32as_v5","Standard_E32bds_v5","Standard_E32bs_v5","Standard_E32d_v4","Standard_E32d_v5","Standard_E32ds_v4","Standard_E32ds_v5","Standard_E32pds_v5","Standard_E32ps_v5","Standard_E32s_v3","Standard_E32s_v4","Standard_E32s_v5","Standard_E4_v3","Standard_E4_v4","Standard_E4_v5","Standard_E4","Standard_E4","Standard_E4","Standard_E4","Standard_E4","Standard_E4","Standard_E4","Standard_E4","Standard_E48_v3","Standard_E48_v4","Standard_E48_v5","Standard_E48a_v4","Standard_E48ads_v5","Standard_E48as_v4","Standard_E48as_v5","Standard_E48bds_v5","Standard_E48bs_v5","Standard_E48d_v4","Standard_E48d_v5","Standard_E48ds_v4","Standard_E48ds_v5","Standard_E48s_v3","Standard_E48s_v4","Standard_E48s_v5","Standard_E4a_v4","Standard_E4ads_v5","Standard_E4as_v4","Standard_E4as_v5","Standard_E4bds_v5","Standard_E4bs_v5","Standard_E4d_v4","Standard_E4d_v5","Standard_E4ds_v4","Standard_E4ds_v5","Standard_E4pds_v5","Standard_E4ps_v5","Standard_E4s_v3","Standard_E4s_v4","Standard_E4s_v5","Standard_E64_v3","Standard_E64_v4","Standard_E64_v5","Standard_E64","Standard_E64","Standard_E64","Standard_E64","Standard_E64","Standard_E64","Standard_E64","Standard_E64","Standard_E64","Standard_E64","Standard_E64","Standard_E64","Standard_E64","Standard_E64","Standard_E64","Standard_E64","Standard_E64a_v4","Standard_E64ads_v5","Standard_E64as_v4","Standard_E64as_v5","Standard_E64bds_v5","Standard_E64bs_v5","Standard_E64d_v5","Standard_E64ds_v4","Standard_E64ds_v5","Standard_E64i_v3","Standard_E64is_v3","Standard_E64s_v3","Standard_E64s_v4","Standard_E64s_v5","Standard_E8_v3","Standard_E8_v4","Standard_E8_v5","Standard_E8","Standard_E8","Standard_E8","Standard_E8"]

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
  vm_size               = local.vmsizes[count.index]
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
