output "vm_ip" {
  value = module.vm.vm_public_ip
}

output "acr_name" {
  value = module.acr.acr_name
}

output "acr_username" {
  value = module.acr.acr_username
}

output "acr_password" {
  value     = module.acr.acr_password
  sensitive = true
}