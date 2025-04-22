output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "subnet_id" {
  value = azurerm_subnet.main.id
}

output "nat_gateway_id" {
  value = azurerm_nat_gateway.main.id
}