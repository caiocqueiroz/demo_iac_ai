variable "resource_group_name" {
  description = "O nome do grupo de recursos para o Terraform State"
  type        = string
  default     = "terraform-state-rg"
}

variable "location" {
  description = "A localização do Azure onde os recursos serão criados"
  type        = string
  default     = "eastus"
}

variable "storage_account_name" {
  description = "O nome da Storage Account para armazenar o estado do Terraform"
  type        = string
  default     = "tfstatehumbleiaca"
}

variable "container_name" {
  description = "O nome do container para armazenar os arquivos de estado"
  type        = string
  default     = "tfstate"
}