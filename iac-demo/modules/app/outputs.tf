output "container_group_name" {
  value = azurerm_container_group.app_container.name
}

output "web_app_url" {
  value       = "https://${azurerm_container_group.app_container.fqdn}"
  description = "The URL of the deployed application"
}