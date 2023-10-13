# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "3b65aa4a-6333-4cf8-9b7d-b41e3df810cb"
  client_id = "7eb1caa7-924d-4d20-aad8-c3dc26bb7132"
  tenant_id = "65582760-3ca3-49d9-91d7-f2fd6402bb4e"
  client_secret = "4zD8Q~~Wd~FqRxkqmQ4m4s5BVBIhg0oW48pcWaZX"

}

terraform {
  backend "azurerm" {
    storage_account_name = "jgstorageterraform"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"

    # rather than defining this inline, the SAS Token can also be sourced
    # from an Environment Variable - more information is available below.
    sas_token = "sp=racwdl&st=2023-06-22T07:42:43Z&se=2023-06-22T15:42:43Z&spr=https&sv=2022-11-02&sr=c&sig=KXcBvKnsbpfKEihguag0qsWGLFQ%2Bl8X95Ke%2BHx6MB1M%3D"
  }
}

resource "azurerm_resource_group" "rg2" {
  name = "${var.rgname}"
  location = "${var.rglocation}"
}

resource "azurerm_virtual_network" "vnet2" {
  name                = "${var.vnet}"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
  address_space       = ["${var.vnet_address}"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "${var.subnet1}"
  }

  tags = {
    environment = "VariablesTopic"
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.nsg2}"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name

  security_rule {
    name                       = "JGSecurity"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
