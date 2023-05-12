# ************************************************
# Network Security Groups
# ************************************************

resource "azurerm_network_security_group" "nsg_bastion" {
  count               = var.vnet_create_bastion == true ? 1 : 0
  name                = "AzureBastionSubnet-nsg"
  location            = var.vnet_region
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_group" "nsg_dv" {
  name                = "${var.opu_code}-${lower(var.vnet_region_code)}-dv-01-snet-nsg"
  location            = var.vnet_region
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_group" "nsg_qa" {
  name                = "${var.opu_code}-${lower(var.vnet_region_code)}-qa-01-snet-nsg"
  location            = var.vnet_region
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_group" "nsg_pub" {
  name                = "${var.opu_code}-${lower(var.vnet_region_code)}-pub-01-snet-nsg"
  location            = var.vnet_region
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_group" "nsg_pdfrontend" {
  name                = "${lower(var.opu_code)}-${lower(var.vnet_region_code)}-pdfrontend-01-snet-nsg"
  location            = var.vnet_region
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_group" "nsg_pdbackend" {
  name                = "${lower(var.opu_code)}-${lower(var.vnet_region_code)}-pdbackend-01-snet-nsg"
  location            = var.vnet_region
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_group" "nsg_exp_01" {
  name                = "${var.opu_code}-${lower(var.vnet_region_code)}-exp-01-snet-nsg"
  location            = var.vnet_region
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# ************************************************
# NSG Associations
# ************************************************

resource "azurerm_subnet_network_security_group_association" "bastion" {
  count                     = var.vnet_create_bastion == true ? 1 : 0
  subnet_id                 = azurerm_subnet.bastion.id
  network_security_group_id = azurerm_network_security_group.nsg_bastion[0].id
}

resource "azurerm_subnet_network_security_group_association" "dv" {
  subnet_id                 = azurerm_subnet.dv.id
  network_security_group_id = azurerm_network_security_group.nsg_dv.id
}

resource "azurerm_subnet_network_security_group_association" "qa" {
  subnet_id                 = azurerm_subnet.qa.id
  network_security_group_id = azurerm_network_security_group.nsg_qa.id
}

resource "azurerm_subnet_network_security_group_association" "pub" {
  subnet_id                 = azurerm_subnet.pub.id
  network_security_group_id = azurerm_network_security_group.nsg_pub.id
}

resource "azurerm_subnet_network_security_group_association" "pdfrontend" {
  subnet_id                 = azurerm_subnet.pdfrontend.id
  network_security_group_id = azurerm_network_security_group.nsg_pdfrontend.id
}

resource "azurerm_subnet_network_security_group_association" "pdbackend" {
  subnet_id                 = azurerm_subnet.pdbackend.id
  network_security_group_id = azurerm_network_security_group.nsg_pdbackend.id
}

resource "azurerm_subnet_network_security_group_association" "exp_01" {
  subnet_id                 = azurerm_subnet.exp_01.id
  network_security_group_id = azurerm_network_security_group.nsg_exp_01.id
}


# ************************************************
# Network Security Groups Output
# ************************************************

output "snet_nsg_bastion_name" {
  value       = var.vnet_create_bastion == true ? azurerm_network_security_group.nsg_bastion[0].name : null
  description = "Name of the Bastion subnet within the VNET"
}

output "snet_nsg_dv_name" {
  value       = azurerm_network_security_group.nsg_dv.name
  description = "Name of the Development subnet within the VNET"
}

output "snet_nsg_qa_name" {
  value       = azurerm_network_security_group.nsg_qa.name
  description = "Name of the QA subnet within the VNET"
}

output "snet_nsg_pub_name" {
  value       = azurerm_network_security_group.nsg_pub.name
  description = "Name of the Public subnet within the VNET"
}

output "snet_nsg_pdfrontend_name" {
  value       = azurerm_network_security_group.nsg_pdfrontend.name
  description = "Name of the Production Frontend subnet within the VNET"
}

output "snet_nsg_pdbackend_name" {
  value       = azurerm_network_security_group.nsg_pdbackend.name
  description = "Name of the Production Backend subnet within the VNET"
}

output "snet_nsg_exp_01_name" {
  value       = azurerm_network_security_group.nsg_exp_01.name
  description = "Name of the Expansion 01 subnet within the VNET"
}
