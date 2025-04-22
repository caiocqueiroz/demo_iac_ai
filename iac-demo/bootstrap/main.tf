# Script de bootstrap para provisionar os recursos necessários para o Terraform State remoto
# Este script deve ser executado apenas uma vez, antes de executar a pipeline principal

provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

module "terraform_state" {
  source = "../modules/terraform-state"

  # Você pode sobrescrever as variáveis padrão aqui, se necessário
  # resource_group_name = "custom-tfstate-rg"
  # location = "westeurope"
  # storage_account_name = "customtfstate123"
  # container_name = "tfstate"
}

output "storage_account_name" {
  value = module.terraform_state.storage_account_name
}

output "container_name" {
  value = module.terraform_state.container_name
}

output "resource_group_name" {
  value = module.terraform_state.resource_group_name
}

# Essa saída é sensível e não será mostrada por padrão no console do Terraform
output "storage_access_key" {
  value     = module.terraform_state.storage_account_primary_access_key
  sensitive = true
}