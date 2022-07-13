variable "location" {
  type        = string
  description = "(Required) The location for all shared infrastructure resources."
}

variable "vnet_name" {
  type        = string
  description = "(Optional) The name of the hub virtual network."
  default     = "hub-vnet"
}

variable "resource_group_name" {
  type        = string
  description = "(Optional) The name of the resource group for hub resources."
  default     = "hub-rg"
}

variable "firewall_subnet_address_prefixes" {
  type        = string
  description = "(Optional) The address prefixes for the Azure firewall subnet"
}
