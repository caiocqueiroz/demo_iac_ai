variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "The address space for the VNet"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "subnet_address_prefix" {
  description = "The address prefix for the subnet"
  type        = string
}

variable "public_ip_name" {
  description = "The name of the public IP"
  type        = string
}

variable "subnet_prefixes" {
  description = "A list of subnet prefixes."
  type        = list(string)
}

variable "resource_group_name" {
  description = "The name of the resource group where the network resources will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be deployed."
  type        = string
  default     = "East US"
}

variable "nat_gateway_name" {
  description = "The name of the NAT Gateway."
  type        = string
}