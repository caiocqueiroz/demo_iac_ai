resource "azurerm_container_group" "app_container" {
  name                = var.container_name
  location            = var.location
  resource_group_name = var.resource_group
  os_type             = var.os_type
  ip_address_type     = "Public"
  dns_name_label      = lower(var.container_name)
  restart_policy      = "OnFailure"

  # Add retry logic for transient Azure errors
  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }

  container {
    name   = var.container_name
    image  = var.image_name
    cpu    = var.cpu
    memory = var.memory

    ports {
      port     = var.ports[0] # Using the first port from the ports list
      protocol = "TCP"
    }

    # Empty environment variables for completeness
    environment_variables        = {}
    secure_environment_variables = {}

    # Add diagnostic settings
    commands = []
  }

  # Add tags for better resource tracking
  tags = {
    environment = "dev"
    managed_by  = "terraform"
    purpose     = "container-instance"
  }
}