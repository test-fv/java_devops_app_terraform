module "rg" {
  source   = "../../modules/resource_group"
  name     = "rg-dev-portfolio"
  location = var.location
}

module "network" {
  source    = "../../modules/network"
  rg_name   = module.rg.name
  location  = var.location
  vnet_name = "vnet-dev"
  project    = var.project
}

module "acr" {
  source   = "../../modules/acr"
  name     = var.acr_name
  rg_name  = module.rg.name
  location = var.location
  acr_name = var.acr_name
}

module "vm" {
  source    = "../../modules/vm"

  vm_name        = var.vm_name
  rg_name        = module.rg.name
  location       = var.location
  subnet_id      = module.network.subnet_id
  vm_size        = var.vm_size

  admin_username = var.admin_username
  ssh_public_key = file("${path.module}/../../keys/azure_vm_key.pub")

  acr_name = module.acr.acr_name
  nsg_id   = module.network.nsg_id
  acr_user = module.acr.acr_username
  acr_pass = module.acr.acr_password
}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

locals {
  acr_name = "acr${var.project}${random_string.suffix.result}"
}
