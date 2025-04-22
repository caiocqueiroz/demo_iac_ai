# Infrastructure as Code (IaC) Demo

This project demonstrates the use of Terraform to deploy a simple web application on Azure using Infrastructure as Code (IaC) principles. The architecture includes various components such as networking, storage, and application deployment, all managed through Terraform modules.

## Project Structure

The project is organized into several modules and environments:

- **modules/**: Contains reusable Terraform modules for different components.
  - **app/**: Module for deploying the web application in a container.
  - **network/**: Module for setting up networking resources (VPC, Subnets, NAT Gateway).
  - **storage/**: Module for creating an Azure Storage Account.

- **environments/**: Contains environment-specific configurations.
  - **dev/**: Development environment configuration.
  - **prod/**: Production environment configuration.

- **main.tf**: Entry point for the Terraform configuration, orchestrating the deployment of the modules.
- **outputs.tf**: Specifies the outputs for the overall project.
- **variables.tf**: Defines the input variables for the overall project.
- **provider.tf**: Specifies the provider configuration for Azure.

## Getting Started

To get started with this project, follow these steps:

1. **Prerequisites**:
   - Install Terraform.
   - Set up an Azure account and configure authentication.

2. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd iac-demo
   ```

3. **Initialize Terraform**:
   Run the following command to initialize the Terraform working directory:
   ```bash
   terraform init
   ```

4. **Configure Variables**:
   Update the `terraform.tfvars` files in the `environments/dev` and `environments/prod` directories with your specific configurations.

5. **Deploy the Infrastructure**:
   To deploy the development environment, run:
   ```bash
   terraform apply -var-file=environments/dev/terraform.tfvars
   ```

   For the production environment, run:
   ```bash
   terraform apply -var-file=environments/prod/terraform.tfvars
   ```

6. **Access the Application**:
   After deployment, you can access the web application using the output URL provided by the app module.

## Conclusion

This project showcases how to leverage Terraform for deploying a web application on Azure, emphasizing the benefits of Infrastructure as Code. By using modular design, the project promotes reusability and maintainability of the infrastructure code.