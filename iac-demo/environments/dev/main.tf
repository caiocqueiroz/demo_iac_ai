// Create the resource group instead of referencing an existing one
resource "azurerm_resource_group" "dev" {
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source                = "../../modules/network"
  resource_group_name   = azurerm_resource_group.dev.name
  location              = azurerm_resource_group.dev.location
  vnet_name             = var.vnet_name
  subnet_name           = var.subnet_name
  address_space         = var.address_space
  subnet_prefixes       = var.subnet_prefixes
  nat_gateway_name      = var.nat_gateway_name
  public_ip_name        = "${var.resource_group_name}-pip"
  subnet_address_prefix = var.subnet_address_prefix
}

module "storage" {
  source               = "../../modules/storage"
  resource_group_name  = azurerm_resource_group.dev.name
  location             = azurerm_resource_group.dev.location
  storage_account_name = var.storage_account_name
  environment          = "dev" # Adding the missing environment parameter
}

# module "app" {
#   source         = "../../modules/app"
#   resource_group = azurerm_resource_group.dev.name
#   location       = azurerm_resource_group.dev.location
#   container_name = var.container_name
#   image_name     = var.app_image
# }