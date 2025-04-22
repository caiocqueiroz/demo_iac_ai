output "storage_account_name" {
  value       = azurerm_storage_account.tfstate.name
  description = "O nome da Storage Account criada"
}

output "container_name" {
  value       = azurerm_storage_container.tfstate.name
  description = "O nome do container criado na Storage Account"
}

output "resource_group_name" {
  value       = azurerm_resource_group.tfstate.name
  description = "O nome do grupo de recursos criado para o Terraform State"
}

output "storage_account_primary_access_key" {
  value       = azurerm_storage_account.tfstate.primary_access_key
  description = "A chave de acesso primária da Storage Account"
  sensitive   = true
}