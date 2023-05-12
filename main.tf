terraform {
  cloud {
    organization = "trombs-test-org"
    hostname = "app.staging.terraform.io"

    workspaces {
      name = "tfc_testing"
    }
  }
    required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

variable "tags" {
  type = map(string)
  default = {
    Name = "drift-test"
  }
}

module "subnet_addrs" {
  source = "hashicorp/subnets/cidr"

  base_cidr_block = "10.0.0.0/8"
  networks = [
    {
      name     = "bastion"
      new_bits = 4
    },
    {
      name     = "dev"
      new_bits = 4
    },
    {
      name     = "qa"
      new_bits = 4
    },
    {
      name     = "pub"
      new_bits = 4
    },
    {
      name     = "pd-frontend"
      new_bits = 3
    },
    {
      name     = "pd-backend"
      new_bits = 3
    },
    {
      name     = "expansion-1"
      new_bits = 1
    },
  ]
}

module "qco-vnet" {
  source  = "./vnet"
  # insert required variables here
  tags     = var.tags
  opu_code = "test"

  # Network Resource Group
  resource_group_name = azurerm_resource_group.vnet.name

  # Vnet Information
  vnet_address_space = [module.subnet_addrs.base_cidr_block]

  vnet_dns_servers = ["10.0.0.4"]

  #SNet Information
  snet_bastion_address_prefixes     = [module.subnet_addrs.network_cidr_blocks["bastion"]]
  snet_dv_address_prefixes          = [module.subnet_addrs.network_cidr_blocks["dev"]]
  snet_qa_address_prefixes          = [module.subnet_addrs.network_cidr_blocks["qa"]]
  snet_pub_address_prefixes         = [module.subnet_addrs.network_cidr_blocks["pub"]]
  snet_pd_frontend_address_prefixes = [module.subnet_addrs.network_cidr_blocks["pd-frontend"]]
  snet_pd_backend_address_prefixes  = [module.subnet_addrs.network_cidr_blocks["pd-backend"]]
  snet_exp_01_address_prefixes      = [module.subnet_addrs.network_cidr_blocks["expansion-1"]]
}

resource "azurerm_resource_group" "vnet" {
  name     = "example-resources"
  location = "West Europe"
}
