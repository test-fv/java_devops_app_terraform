variable "rg_name" {}
variable "location" {}
variable "subnet_id" {}
variable "vm_size" {}
variable "admin_username" {
  type = string
}

variable "ssh_public_key" {
  type = string
}
variable "acr_name" {
  type = string
}
variable "vm_name" {
  type = string
}

variable "acr_user" {
  type = string
}

variable "acr_pass" {
  type      = string
  sensitive = true
}

variable "nsg_id" {
  type = string
}