variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "ssh_public_key" {
  type = string
}

variable "acr_name" {
  type = string
}

variable "project" {
  description = "Prefijo del proyecto"
  type        = string
}