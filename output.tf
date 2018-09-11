output "vnet_id" {
  value = "${azurerm_virtual_network.vnet.id}"
}

output "vnetname" {
  value = "${azurerm_virtual_network.vnet.name}"
}

output "resourcegroup_id" {
  value = "${azurerm_resource_group.rg.id}"
}

output "resourcegroup_name" {
  value = "${azurerm_resource_group.rg.name}"
}


