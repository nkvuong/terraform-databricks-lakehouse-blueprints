output "workspace_name" {
  value       = azurerm_databricks_workspace.this.name
  description = "Name of the Databricks workspace"
}

output "workspace_id" {
  value       = azurerm_databricks_workspace.this.id
  description = "ID of the Databricks workspace"
}

output "workspace_url" {
  value = azurerm_databricks_workspace.this.workspace_url
}
