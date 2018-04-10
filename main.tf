resource "azurerm_resource_group" "rg" {
  name     = "${var.name}-${var.env}"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.name}-vnet-${var.env}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  address_space       = ["${var.address_space}"]
  location            = "${azurerm_resource_group.rg.location}"
}

resource "azurerm_subnet" "sb" {
  count                = "4"
  name                 = "${var.name}-subnet-${count.index}-${var.env}"
  resource_group_name  = "${azurerm_virtual_network.vnet.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "${cidrsubnet("${var.source_range}", 4, count.index)}"
}

data "template_file" "privatedns" {
  template = "${file("${path.module}/template/azuredns.json")}"
}

resource "azurerm_template_deployment" "azuredns" {
  template_body       = "${data.template_file.privatedns.rendered}"
  name                = "azure-dns-${var.env}"
  deployment_mode     = "Incremental"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  parameters = {
    zoneName     = "service.core-compute-${var.env}.internal"
    vnetName     = "${azurerm_virtual_network.vnet.name}"
    subscription = "${var.subscription}"
  }
}
