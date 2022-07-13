variable "workspace_name" {
  type        = string
  description = "Name of Databricks workspace"
}

variable "databricks_resource_group_name" {
  type        = string
  description = "Name of resource group into which Databricks will be deployed"
}

variable "databricks_virtual_network_name" {
  type        = string
  description = "Name of existing virtual network into which Databricks will be deployed"
}

variable "private_subnet_name" {
  type        = string
  description = "Name of the private subnet"
}

variable "public_subnet_name" {
  type        = string
  description = "Name of the public subnet"
}

variable "public_subnet_association_id" {
  type        = string
  description = "Public subnet association id"
}

variable "private_subnet_association_id" {
  type        = string
  description = "Private subnet association id"
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to attach to Databricks workspace"
  default     = {}
}
