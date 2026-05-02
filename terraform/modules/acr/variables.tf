variable "name" {}
variable "rg_name" {}
variable "location" {}
variable "acr_name" {
  description = "acr${var.project}${random_string.suffix.result}"
  type        = string
}