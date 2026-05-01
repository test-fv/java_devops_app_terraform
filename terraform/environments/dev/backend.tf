terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tf-state"
    storage_account_name = "tfstate123"
    container_name       = "tfstate"
    key                  = "dev.tfstate"
  }
}