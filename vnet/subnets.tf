# ************************************************
# Subnet Information
# ************************************************
resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet" # Requires this exact name for service
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = var.snet_bastion_address_prefixes
}

resource "azurerm_subnet" "dv" {
  name                                           = "${lower(var.opu_code)}-${lower(var.vnet_region_code)}-dv-01-snet"
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = var.snet_dv_address_prefixes
  service_endpoints                              = var.snet_dv_service_endpoints
  enforce_private_link_endpoint_network_policies = var.snet_dv_enforce_pep_policies
}

resource "azurerm_subnet" "qa" {
  name                                           = "${lower(var.opu_code)}-${lower(var.vnet_region_code)}-qa-01-snet"
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = var.snet_qa_address_prefixes
  service_endpoints                              = var.snet_qa_service_endpoints
  enforce_private_link_endpoint_network_policies = var.snet_qa_enforce_pep_policies
}

resource "azurerm_subnet" "pub" {
  name                                           = "${lower(var.opu_code)}-${lower(var.vnet_region_code)}-pub-01-snet"
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = var.snet_pub_address_prefixes
  service_endpoints                              = var.snet_pub_service_endpoints
  enforce_private_link_endpoint_network_policies = var.snet_pub_enforce_pep_policies
}

resource "azurerm_subnet" "pdfrontend" {
  name                                           = "${lower(var.opu_code)}-${lower(var.vnet_region_code)}-pdfrontend-01-snet"
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = var.snet_pd_frontend_address_prefixes
  service_endpoints                              = var.snet_pd_frontend_service_endpoints
  enforce_private_link_endpoint_network_policies = var.snet_pd_frontend_enforce_pep_policies
}

resource "azurerm_subnet" "pdbackend" {
  name                                           = "${lower(var.opu_code)}-${lower(var.vnet_region_code)}-pdbackend-01-snet"
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = var.snet_pd_backend_address_prefixes
  service_endpoints                              = var.snet_pd_backend_service_endpoints
  enforce_private_link_endpoint_network_policies = var.snet_pd_backend_enforce_pep_policies
}

resource "azurerm_subnet" "exp_01" {
  name                                           = "${lower(var.opu_code)}-${lower(var.vnet_region_code)}-exp-01-snet"
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = var.snet_exp_01_address_prefixes
  service_endpoints                              = var.snet_exp_01_service_endpoints
  enforce_private_link_endpoint_network_policies = var.snet_exp_01_enforce_pep_policies
}

# ************************************************
# Subnet Output
# ************************************************
output "snet_bastion_name" {
  value       = azurerm_subnet.bastion.name
  description = "Name of the Bastion subnet"
}

output "snet_bastion_id" {
  value       = azurerm_subnet.bastion.id
  description = "ID of the Bastion subnet"
}

output "snet_dv_name" {
  value       = azurerm_subnet.dv.name
  description = "Name of the Development subnet"
}

output "snet_dv_id" {
  value       = azurerm_subnet.dv.id
  description = "ID of the Development subnet"
}

output "snet_qa_name" {
  value       = azurerm_subnet.qa.name
  description = "Name of the QA subnet"
}

output "snet_qa_id" {
  value       = azurerm_subnet.qa.id
  description = "ID of the QA subnet"
}

output "snet_pub_name" {
  value       = azurerm_subnet.pub.name
  description = "Name of the Public subnet"
}

output "snet_pub_id" {
  value       = azurerm_subnet.pub.id
  description = "ID of the Public subnet"
}

output "snet_pdfrontend_name" {
  value       = azurerm_subnet.pdfrontend.name
  description = "Name of the Production Frontend subnet"
}
output "snet_pdfrontend_id" {
  value       = azurerm_subnet.pdfrontend.id
  description = "ID of the Production Frontend subnet"
}

output "snet_pdbackend_name" {
  value       = azurerm_subnet.pdbackend.name
  description = "Name of the Production Backend subnet"
}
output "snet_pdbackend_id" {
  value       = azurerm_subnet.pdbackend.id
  description = "ID of the Production Backend subnet"
}

output "snet_exp_01_name" {
  value       = azurerm_subnet.exp_01.name
  description = "Name of the expansion 01 subnet"
}

output "snet_exp_01_id" {
  value       = azurerm_subnet.exp_01.id
  description = "ID of the expansion 01 subnet"
}
