# variable "app_image" {
#   description = "The Docker image for the web application"
#   type        = string
# }

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

# variable "container_name" {
#   description = "The name of the Azure Container Instance"
#   type        = string
# }

variable "location" {
  description = "The Azure region where resources will be deployed"
  type        = string
  default     = "East US"
}

variable "vnet_name" {
  description = "The name of the Virtual Network"
  type        = string
}

variable "subnet_name" {
  description = "The name of the Subnet"
  type        = string
}

variable "nat_gateway_name" {
  description = "The name of the NAT Gateway"
  type        = string
}

variable "address_space" {
  description = "The address space for the VNet"
  type        = string
}

variable "subnet_prefixes" {
  description = "A list of subnet prefixes"
  type        = list(string)
}

variable "subnet_address_prefix" {
  description = "The address prefix for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}