provider "azurerm" {
  features {}

  # We'll use environment variables for authentication
  # This is more secure than hardcoding credentials
  # Set these with:
  # export ARM_SUBSCRIPTION_ID="your-subscription-id"
  # export ARM_TENANT_ID="your-tenant-id"
  # export ARM_CLIENT_ID="your-client-id"
  # export ARM_CLIENT_SECRET="your-client-secret"

  # Alternatively, uncomment and set values directly for testing
  # subscription_id = "your-subscription-id"
  # tenant_id = "your-tenant-id"
  # client_id = "your-client-id"
  # client_secret = "your-client-secret"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfstatehumbleiaca"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
    # Authentication is handled by the Azure CLI or environment variables:
    # ARM_ACCESS_KEY or ARM_SAS_TOKEN
  }
}