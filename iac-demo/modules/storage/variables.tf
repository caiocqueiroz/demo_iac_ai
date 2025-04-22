variable "environment" {
  description = "The environment (e.g., dev, prod)"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region"
  type        = string
}

variable "allowed_ip_ranges" {
  description = "List of allowed IP ranges for the storage account"
  type        = list(string)
  default     = []
}

variable "allowed_subnet_ids" {
  description = "List of allowed subnet IDs for the storage account"
  type        = list(string)
  default     = []
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to send diagnostics"
  type        = string
  default     = null
}

variable "data_classification" {
  description = "The data classification level (e.g., public, internal, confidential, restricted)"
  type        = string
  default     = "confidential"
}