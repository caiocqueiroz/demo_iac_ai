resource "azurerm_storage_account" "example" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Security settings to disable anonymous public access
  public_network_access_enabled   = true
  allow_nested_items_to_be_public = false

  tags = {
    environment = var.environment
  }
}

resource "azurerm_storage_container" "example" {
  name                  = "my-container"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}