resource "azurerm_resource_group" "rg" {
  name     = "${var.name}-${var.env}"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.name}-vnet-${var.env}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  address_space       = ["${var.address_space}"]
  location            = "${azurerm_resource_group.rg.location}"
  dns_servers         = ["${var.lb_private_ip_address}", "${var.microsoft_external_dns}"]

  lifecycle {
    ignore_changes = ["address_space", "dns_servers"]
  }
}

resource "azurerm_subnet" "sb" {
  count                = "4"
  name                 = "${var.name}-subnet-${count.index}-${var.env}"
  resource_group_name  = "${azurerm_virtual_network.vnet.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "${cidrsubnet("${var.source_range}", 4, count.index)}"
  service_endpoints    = "${"

  lifecycle {
    ignore_changes = "address_prefix"
  }
}
