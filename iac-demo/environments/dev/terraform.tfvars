# Fixed unexpected attributes
resource_group_name = "caiocqueiroz-dev-rg"
location            = "West US 2"
address_space       = "10.0.0.0/16"
subnet_prefixes     = ["10.0.1.0/24"]
nat_gateway_name    = "caiocqueiroz-dev-nat-gateway"
# app_image            = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
# container_name       = "caiocqueiroz-dev-container"
vnet_name            = "caiocqueiroz-dev-vnet"
subnet_name          = "caiocqueiroz-dev-subnet"
storage_account_name = "caiocqueirozdevsa"