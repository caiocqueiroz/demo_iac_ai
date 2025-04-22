output "app_url" {
  value       = module.app.web_app_url
  description = "The URL of the deployed application"
}

output "subnet_id" {
  value       = module.network.subnet_id
  description = "The ID of the created subnet"
}

output "storage_account_name" {
  value       = module.storage.storage_account_name
  description = "The name of the storage account"
}