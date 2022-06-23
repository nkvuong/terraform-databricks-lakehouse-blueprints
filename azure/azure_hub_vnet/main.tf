resource "azurerm_resource_group" "this" {
  name = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "this" {
  name = var.vnet_name
  location = azurerm_resource_group.this.location
}

resource "azurerm_firewall" "this" {
  
}

resource "azurerm_route_table" "this" {
  
}
