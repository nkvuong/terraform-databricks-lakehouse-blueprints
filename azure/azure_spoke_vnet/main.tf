data "azurerm_virtual_network" "hub_vnet" {
  name                = var.hub_vnet_name
  resource_group_name = var.hub_vnet_resource_group_name
}

resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = data.azurerm_virtual_network.hub_vnet.location
}

resource "azurerm_virtual_network" "this" {
  name                = "spoke-vnet-${var.project_name}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = [var.vnet_address_space]
}

resource "azurerm_virtual_network_peering" "this" {
  name                      = format("from-%s-to-%s-peer", azurerm_virtual_network.this.name, data.azurerm_virtual_network.hub_vnet.name)
  resource_group_name       = azurerm_resource_group.this.name
  virtual_network_name      = azurerm_virtual_network.this.name
  remote_virtual_network_id = data.azurerm_virtual_network.hub_vnet.id
}

resource "azurerm_network_security_group" "this" {
  name                = "databricks-nsg-${var.project_name}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

module "databricks_workspace" {
  source                          = "../modules/azure-databricks-workspace"
  workspace_name                  = var.workspace_name
  databricks_resource_group_name  = azurerm_resource_group.this.name
  databricks_virtual_network_name = azurerm_virtual_network.this.name
  public_subnet_address_prefixes  = var.public_subnet_address_prefixes
  private_subnet_address_prefixes = var.private_subnet_address_prefixes
  tags                            = var.tags
}
