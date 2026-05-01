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
}

module "acr" {
  source   = "../../modules/acr"
  name     = var.acr_name
  rg_name  = module.rg.name
  location = var.location
}

module "vm" {
  source    = "../../modules/vm"
  rg_name   = module.rg.name
  location  = var.location
  subnet_id = module.network.subnet_id
  vm_size   = var.vm_size
  username  = var.username
  ssh_key   = var.ssh_key
  acr_name = module.acr.acr_name
}
