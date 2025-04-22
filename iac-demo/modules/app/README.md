# App Module

This module is responsible for deploying a web application in an Azure Container Instance. It encapsulates all the necessary resources and configurations required to run the application in a containerized environment.

## Usage

To use this module, include it in your Terraform configuration as follows:

```hcl
module "app" {
  source              = "../modules/app"
  image_name          = var.image_name
  resource_group      = var.resource_group
  container_name      = var.container_name
  cpu                 = var.cpu
  memory              = var.memory
  port                = var.port
}
```

## Inputs

| Name              | Description                          | Type   | Default | Required |
|-------------------|--------------------------------------|--------|---------|:--------:|
| image_name        | The name of the container image      | string | n/a     |   yes    |
| resource_group    | The name of the resource group       | string | n/a     |   yes    |
| container_name    | The name of the container            | string | n/a     |   yes    |
| cpu               | The number of CPU cores              | number | 1       |    no    |
| memory            | The amount of memory (in GB)        | number | 1       |    no    |
| port              | The port on which the application listens | number | 80      |    no    |

## Outputs

| Name              | Description                          |
|-------------------|--------------------------------------|
| app_url           | The URL of the deployed web application |