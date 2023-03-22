resource "azurerm_resource_group" "vnet_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_network_security_group" "azurewebappnsg" {
  name                = var.azurerm_network_security_group_name
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_rg.name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.azurerm_network_vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = "websubnet"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "datasubnet"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.azurewebappnsg.id
  }

  tags = {
    environment = "staging"
  }
}
