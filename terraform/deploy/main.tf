#storage account creation to setup & persist tf backend on azure storage blob container

resource "azurerm_resource_group" "tfstate" {
  name     = "tfstatergaplha"
  location = "East US"
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstatescaplha"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = false

  tags = {
    environment = "staging"
  }
}

#use random_string to create resources when tf apply fails due lack of unique name available for a resource creation
# resource "random_string" "resource_code" {
#   length  = 5
#   special = false
#   upper   = false
# }

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstatecalpha"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

#calling of various tf modules

module "vnet" {
  source = "../modules/vnet"
  resource_group_name                 = var.resource_group_name
  location                            = var.location
  azurerm_network_vnet_name           = var.azurerm_network_vnet_name
  azurerm_network_security_group_name = var.azurerm_network_security_group_name
}

