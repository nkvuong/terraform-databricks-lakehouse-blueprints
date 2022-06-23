resource "azurerm_resource_group" "this" {
  name = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "this" {
  name = "spoke-vnet-${var.project_name}"
  location = azurerm_resource_group.this.location
}

resource "azurerm_network_security_group" "this" {
  name = "databricks-nsg-${var.project_name}"
  location = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_subnet" "private_subnet" {
  name                 = "private-subnet-${var.project_name}"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name

  address_prefixes = var.private_subnet_address_prefixes

  delegation {
    name = "databricks-private-subnet-delegation"

    service_delegation {
      name    = "Microsoft.Databricks/workspaces"
      actions = var.service_delegation_actions
    }
  }
}

resource "azurerm_subnet" "public_subnet" {
  name                 = "public-subnet-${var.project_name}"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name

  address_prefixes = var.public_subnet_address_prefixes

  delegation {
    name = "databricks-public-subnet-delegation"

    service_delegation {
      name    = "Microsoft.Databricks/workspaces"
      actions = var.service_delegation_actions
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "public" {
  subnet_id                 = azurerm_subnet.public_subnet.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_subnet_network_security_group_association" "private" {
  subnet_id                 = azurerm_subnet.private_subnet.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_subnet_route_table_association" "public" {
  subnet_id      = azurerm_subnet.public_subnet.id
  route_table_id = var.firewall_route_table_id
}

resource "azurerm_subnet_route_table_association" "private" {
  subnet_id      = azurerm_subnet.private_subnet.id
  route_table_id = var.firewall_route_table_id
}

