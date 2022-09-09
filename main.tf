resource "azurerm_resource_group" "rg" {
  name     = "${var.name}-${var.env}"
  location = var.location

  tags = var.common_tags

}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.name}-vnet-${var.env}"
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["${var.address_space}"]
  location            = azurerm_resource_group.rg.location
  dns_servers         = ["${var.lb_private_ip_address}", "${var.microsoft_external_dns}"]

  tags = var.common_tags

  lifecycle {
    ignore_changes = ["address_space", "dns_servers"]
  }
}

resource "azurerm_subnet" "sb" {
  count                                          = "4"
  name                                           = "${var.name}-subnet-${count.index}-${var.env}"
  resource_group_name                            = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefixes                               = cidrsubnet("${var.source_range}", 4, count.index)
  enforce_private_link_endpoint_network_policies = var.iaas_subnet_enforce_private_link_endpoint_network_policies

  lifecycle {
    ignore_changes = ["address_prefixes"]
  }
}

resource "azurerm_subnet" "postgresql_subnet" {
  for_each = var.postgresql_subnet_cidr_blocks

  address_prefixes     = [var.postgresql_subnet_cidr_blocks]
  name                 = "postgresql"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}
