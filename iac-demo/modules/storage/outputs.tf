output "storage_account_name" {
  value = azurerm_storage_account.example.name
}

output "primary_access_key" {
  value = azurerm_storage_account.example.primary_access_key
}