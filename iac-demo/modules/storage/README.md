# Storage Module

This module is responsible for creating an Azure Storage Account. It provides the necessary Terraform configuration to set up the storage resources required for the application.

## Usage

To use this module, include it in your Terraform configuration as follows:

```hcl
module "storage" {
  source              = "../modules/storage"
  storage_account_name = var.storage_account_name
  resource_group_name  = var.resource_group_name
  location            = var.location
  account_tier       = var.account_tier
  account_replication = var.account_replication
}
```

## Inputs

| Name                     | Description                                   | Type   | Default | Required |
|--------------------------|-----------------------------------------------|--------|---------|:--------:|
| storage_account_name     | The name of the storage account.              | string | n/a     |   yes    |
| resource_group_name      | The name of the resource group.               | string | n/a     |   yes    |
| location                 | The Azure region where the storage account will be created. | string | n/a     |   yes    |
| account_tier             | The performance tier of the storage account (e.g., Standard, Premium). | string | "Standard" | no |
| account_replication       | The replication strategy for the storage account (e.g., LRS, GRS). | string | "LRS"   | no |

## Outputs

| Name                     | Description                                   |
|--------------------------|-----------------------------------------------|
| storage_account_name     | The name of the created storage account.      |
| primary_access_key       | The primary access key for the storage account. |
| secondary_access_key     | The secondary access key for the storage account. |

## Example

```hcl
module "storage" {
  source              = "../modules/storage"
  storage_account_name = "mystorageaccount"
  resource_group_name  = "myresourcegroup"
  location            = "East US"
  account_tier       = "Standard"
  account_replication = "LRS"
}
```

## Notes

- Ensure that the storage account name is globally unique.
- Adjust the `account_tier` and `account_replication` as per your requirements.