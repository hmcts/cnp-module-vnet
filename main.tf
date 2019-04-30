resource "azurerm_resource_group" "rg" {
  name     = "${var.name}-${var.env}"
  location = "${var.location}"

  tags = "${var.common_tags}"

}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.name}-vnet-${var.env}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  address_space       = ["${var.address_space}"]
  location            = "${azurerm_resource_group.rg.location}"
  dns_servers         = ["${var.lb_private_ip_address}", "${var.microsoft_external_dns}"]

  tags = "${var.common_tags}"

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

  lifecycle {
    ignore_changes = "address_prefix"
  }
}
# Add Palo Alto Subnets
resource "azurerm_subnet" "palo_mgmt_sb" {
  name                 = "palo-mgmt"
  resource_group_name  = "${azurerm_virtual_network.vnet.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "${cidrsubnet(element(azurerm_virtual_network.vnet.address_space,0), 6, 21)}"
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Storage"]
}

resource "azurerm_subnet" "palo_trusted_sb" {
  name                 = "palo-trusted"
  resource_group_name  = "${azurerm_virtual_network.vnet.resource_group_name}" 
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "${cidrsubnet(element(azurerm_virtual_network.vnet.address_space,0), 6, 23)}"
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Storage"]
}

resource "azurerm_subnet" "palo_untrusted_sb" {
  name                 = "palo-untrusted"
  resource_group_name  = "${azurerm_virtual_network.vnet.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "${cidrsubnet(element(azurerm_virtual_network.vnet.address_space,0), 6, 22)}"
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Storage"]
}

resource "azurerm_subnet" "elasticsearch_sb" {
  name                 = "elasticsearch"
  resource_group_name  = "${azurerm_virtual_network.vnet.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "${cidrsubnet(element(azurerm_virtual_network.vnet.address_space,0), 4, 6)}"
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Storage"]
}
