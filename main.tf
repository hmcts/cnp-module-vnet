resource "azurerm_resource_group" "rg" {
  name     = "${var.name}-${var.env}"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.name}-vnet-${var.env}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  address_space       = "${var.address_space}"
  location            = "${azurerm_resource_group.rg.location}"
  dns_servers         = ["${var.lb_private_ip_address}", "${var.microsoft_external_dns}"]
}

resource "azurerm_subnet" "sb" {
  count                = "${length(var.address_prefixes)}"
  name                 = "${var.name}-subnet-${count.index}-${var.env}"
  resource_group_name  = "${azurerm_virtual_network.vnet.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "${element(var.address_prefixes,count.index)}"
}


resource "azurerm_management_lock" "vnet-lock" {
  count      = "${var.ephemeral}"
  name       = "resource-group-level"
  scope      = "${azurerm_virtual_network.vnet.id}"
  lock_level = "CanNotDelete"
  notes      = "Delete prevented for persistant peering"
}