provider "azurerm" {
  features {}
}

# Create a new Resource Group
resource "azurerm_resource_group" "project_group" {
  name     = "rg-nsg-test"
  location = "UK South"
}
locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }

  default_tags = {
    environment = "dev"
  }

  tags = merge(local.module_tag, local.default_tags)
}

module "azure-nsg" {
  source  = "andrewCluey/nsg/azurerm"
  version = "1.0.0"

  nsg_name            = "dev-nsg"
  resource_group_name = azurerm_resource_group.project_group.name
  location            = "UK South"
  tags                = local.tags
  security_rules = [
    {
      name                       = "W32Time",
      priority                   = "100"
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "UDP"
      source_port_range          = "*"
      destination_port_range     = "123"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "TLS_IN",
      priority                   = "110"
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "TCP"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "WEB_OUT",
      priority                   = "120"
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "TCP"
      source_port_range          = "*"
      destination_port_ranges    = ["80", "443"]
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}