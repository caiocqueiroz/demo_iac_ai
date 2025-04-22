# Módulo para criar recursos para armazenar o estado do Terraform no Azure

# Grupo de recursos para o Terraform State
resource "azurerm_resource_group" "tfstate" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = "terraform-state"
    managed-by  = "terraform"
  }
}

# Storage Account para armazenar os arquivos de estado
resource "azurerm_storage_account" "tfstate" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  blob_properties {
    versioning_enabled = true # Habilita versionamento para recuperar estados antigos

    container_delete_retention_policy {
      days = 7
    }
  }

  tags = {
    environment = "terraform-state"
    managed-by  = "terraform"
  }
}

# Container para os arquivos de estado
resource "azurerm_storage_container" "tfstate" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private" # O acesso deve ser privado por segurança
}

# Configurando bloqueio para evitar exclusão acidental
resource "azurerm_management_lock" "tfstate_lock" {
  name       = "terraform-state-lock"
  scope      = azurerm_resource_group.tfstate.id
  lock_level = "CanNotDelete"
  notes      = "Protege o grupo de recursos de exclusão acidental"
}