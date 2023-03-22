variable "resource_group_name" {
    type        = string 
    description = "The name of resource group to create the resources in"
}

variable "location" {
    type        = string 
    description = "The azure region of deployment"
}

variable "azurerm_network_vnet_name" {
    type        = string 
    description = "The name of vnet"
}

variable "azurerm_network_security_group_name" {
    type        = string 
    description = "The name of network security group"
}

