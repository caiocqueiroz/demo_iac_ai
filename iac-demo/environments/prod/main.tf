resource "azurerm_resource_group" "prod" {
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source                = "../../modules/network"
  resource_group_name   = azurerm_resource_group.prod.name
  location              = azurerm_resource_group.prod.location
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
  resource_group_name  = azurerm_resource_group.prod.name
  location             = azurerm_resource_group.prod.location
  storage_account_name = var.storage_account_name
  environment          = "prod"
}

module "app" {
  source         = "../../modules/app"
  resource_group = azurerm_resource_group.prod.name
  location       = azurerm_resource_group.prod.location
  container_name = var.container_name
  image_name     = var.app_image
}