provider "azurerm" {}

variable "name" {
  type    = "string"
  default = "inspec-vnet"
}

variable "env" {
  default = "integration"
}

variable "location" {
  default = "UK South"
}

variable "netnum" {
  default = "2"
}

variable "root_address_space" {
  default = "10.0.0.0/8"
}

module "vnet" {
  source                = "../../../../../"
  name                  = "${var.name}"
  location              = "${var.location}"
  address_space         = "${cidrsubnet("${var.root_address_space}", 6, "${var.netnum}")}"
  source_range          = "${cidrsubnet("${var.root_address_space}", 6, "${var.netnum}")}"
  env                   = "${var.env}"
  lb_private_ip_address = "${cidrhost("${cidrsubnet("${cidrsubnet("${var.root_address_space}", 6, "${var.netnum}")}",4, 2)}", -2)}"
}
