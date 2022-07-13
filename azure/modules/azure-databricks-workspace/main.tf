data "azurerm_virtual_network" "this" {
  name = var.databricks_virtual_network_name
  resource_group_name = var.databricks_resource_group_name
}

locals {
  managed_resource_group_name = "databricks-rg-${var.workspace_name}"
}

resource "azurerm_databricks_workspace" "this" {
  name                        = var.workspace_name
  resource_group_name         = data.azurerm_virtual_network.this.resource_group_name
  managed_resource_group_name = local.managed_resource_group_name
  location                    = data.azurerm_virtual_network.this.location
  sku                         = "premium"

  custom_parameters {
    no_public_ip                                         = true
    virtual_network_id                                   = data.azurerm_virtual_network.this.id
    public_subnet_name                                   = azurerm_subnet.public_subnet.name
    private_subnet_name                                  = azurerm_subnet.private_subnet.name
    public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.public.id
    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.private.id
  }

  tags = var.tags
}
