# Network Module

This module is responsible for setting up the necessary network infrastructure for the application. It includes the creation of a Virtual Network (VPC), Subnets, and a NAT Gateway to facilitate secure communication between the application and the internet.

## Resources Created

- **Virtual Network (VPC)**: A logically isolated network in Azure.
- **Subnets**: Segments within the VPC to organize and secure resources.
- **NAT Gateway**: Allows outbound internet access for resources in the private subnet.

## Usage

To use this module, include it in your Terraform configuration as follows:

```hcl
module "network" {
  source              = "../modules/network"
  vpc_name            = var.vpc_name
  address_space       = var.address_space
  subnet_prefixes     = var.subnet_prefixes
  ...
}
```

## Inputs

| Name             | Description                          | Type   | Default | Required |
|------------------|--------------------------------------|--------|---------|:--------:|
| vpc_name         | The name of the Virtual Network      | string | n/a     |   yes    |
| address_space    | The address space for the VPC       | list   | n/a     |   yes    |
| subnet_prefixes  | List of subnet CIDR prefixes         | list   | n/a     |   yes    |

## Outputs

| Name             | Description                          |
|------------------|--------------------------------------|
| vpc_id           | The ID of the created Virtual Network|
| subnet_ids       | List of IDs of the created Subnets   |

## Example

An example of how to call this module can be found in the `environments/dev/main.tf` file.