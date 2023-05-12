# *********************************************
# Metadata
# *********************************************
variable "opu_code" {
  type        = string
  description = "OPU Code"
}

variable "tags" {
  type        = map(any)
  description = "A map of the tags to use on the resources that are deployed with this module."
}

# *********************************************
# Resource Group Informtion
# *********************************************
variable "resource_group_name" {
  type        = string
  default     = "network-pd-rg"
  description = "Network resource group name"
}

# *********************************************
# VNET Informtion
# *********************************************

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space of the vnet"
}

variable "vnet_dns_servers" {
  type        = list(string)
  description = "DNS servers to be used by the vnet"
}

variable "vnet_region" {
  type        = string
  default     = "southcentralus"
  description = "Azure Region"
}

variable "vnet_region_code" {
  type        = string
  default     = "scus"
  description = "Azure Region"
}

variable "vnet_create_bastion" {
  type        = bool
  default     = false
  description = "Create Bastion subnet for this vnet"
}

variable "vnet_create_network_watcher" {
  type        = bool
  default     = false
  description = "Create Network Watcher for this vnet"
}

# *********************************************
# Subnet Informtion
# *********************************************

# Bastion Subnet
variable "snet_bastion_address_prefixes" {
  type        = list(string)
  description = "Subnet prefix for Bastion subnet"
}

# Development Subnet
variable "snet_dv_address_prefixes" {
  type        = list(string)
  description = "Subnet prefix for Dev Internal subnet"
}

variable "snet_dv_service_endpoints" {
  type        = list(string)
  default     = []
  description = "Service Endpoints available on the Development subnet"
}

variable "snet_dv_enforce_pep_policies" {
  type        = bool
  default     = false
  description = "Enforce Private Endpoints Policies on the Development subnet. Set to 'true' if Private Endpoints are in use."
}

# QA Subnet
variable "snet_qa_address_prefixes" {
  type        = list(string)
  description = "Subnet prefix for QA Internal subnet"
}

variable "snet_qa_service_endpoints" {
  type        = list(string)
  default     = []
  description = "Service Endpoints available on the QA subnet"
}

variable "snet_qa_enforce_pep_policies" {
  type        = bool
  default     = false
  description = "Enforce Private Endpoints Policies on the QA subnet. Set to 'true' if Private Endpoints are in use."
}

# Public Subnet
variable "snet_pub_address_prefixes" {
  type        = list(string)
  description = "Subnet prefix for Public subnet"
}

variable "snet_pub_service_endpoints" {
  type        = list(string)
  default     = []
  description = "Service Endpoints available on the Public subnet"
}

variable "snet_pub_enforce_pep_policies" {
  type        = bool
  default     = false
  description = "Enforce Private Endpoints Policies on the Public subnet. Set to 'true' if Private Endpoints are in use."
}

# Production Frontend Subnet
variable "snet_pd_frontend_address_prefixes" {
  type        = list(string)
  description = "Subnet prefix for Production frontend Internal subnet"
}

variable "snet_pd_frontend_service_endpoints" {
  type        = list(string)
  default     = []
  description = "Service Endpoints available on the Production frontend subnet"
}

variable "snet_pd_frontend_enforce_pep_policies" {
  type        = bool
  default     = false
  description = "Enforce Private Endpoints Policies on the Production frontend subnet. Set to 'true' if Private Endpoints are in use."
}

# Production Backend Subnet
variable "snet_pd_backend_address_prefixes" {
  type        = list(string)
  description = "Subnet prefix for Production Backend Internal subnet"
}

variable "snet_pd_backend_service_endpoints" {
  type        = list(string)
  default     = []
  description = "Service Endpoints available on the Production Backend subnet"
}

variable "snet_pd_backend_enforce_pep_policies" {
  type        = bool
  default     = false
  description = "Enforce Private Endpoints Policies on the Production Backend subnet. Set to 'true' if Private Endpoints are in use."
}

# Expansion 01 Subnet
variable "snet_exp_01_address_prefixes" {
  type        = list(string)
  description = "Subnet prefix for Expansion 01 subnet"
}

variable "snet_exp_01_service_endpoints" {
  type        = list(string)
  default     = []
  description = "Service Endpoints available on the Expansion 01 subnet"
}

variable "snet_exp_01_enforce_pep_policies" {
  type        = bool
  default     = false
  description = "Enforce Private Endpoints Policies on the Expansion 01 subnet. Set to 'true' if Private Endpoints are in use."
}
