variable "image_name" {
  description = "The name of the container image to deploy."
  type        = string
}

variable "resource_group" {
  description = "The name of the resource group where the application will be deployed."
  type        = string
}

variable "container_name" {
  description = "The name of the Azure Container Instance."
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be deployed."
  type        = string
}

variable "cpu" {
  description = "The number of CPU cores to allocate for the container."
  type        = number
  default     = 1
}

variable "memory" {
  description = "The amount of memory (in GB) to allocate for the container."
  type        = number
  default     = 1.5
}

variable "os_type" {
  description = "The operating system type for the container."
  type        = string
  default     = "Linux"
}

variable "ports" {
  description = "The ports to expose for the container."
  type        = list(number)
  default     = [80]
}