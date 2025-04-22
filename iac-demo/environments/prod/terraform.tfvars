# Fixed unexpected attributes
resource_group_name  = "prod-resource-group"
location             = "East US"
address_space        = "10.0.0.0/16"
subnet_prefixes      = ["10.0.1.0/24"]
nat_gateway_name     = "prod-nat-gateway"
app_image            = "myregistry.azurecr.io/myapp:latest" # Changed from container_image
container_name       = "myapp-container"
storage_account_name = "mystorageaccountprod"
vnet_name            = "prod-vnet"
subnet_name          = "prod-subnet"