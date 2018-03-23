output "vnet_id" {
  value = "${azurerm_virtual_network.vnet.id}"
}

output "vnetname" {
  value = "${azurerm_virtual_network.vnet.name}"
}

# output "subnet_ids" {
#   value = ["${azurerm_subnet.sb.*.id}"]
# }

# output "subnet_names" {
#   value = ["${azurerm_subnet.sb.*.name}"]
# }

# output "subnetaddress_prefixes" {
#   value = ["${azurerm_subnet.sb.*.address_prefix}"]
# }

output "resourcegroup_id" {
  value = "${azurerm_resource_group.rg.id}"
}

output "resourcegroup_name" {
  value = "${azurerm_resource_group.rg.name}"
}

/*output "subnet_gateway_name" {
  value = "${azurerm_subnet.sb.0.name}"
}

output "subnet_frontend_name" {
  value = "${azurerm_subnet.sb.1.name}"
}

output "subnet_backend_name" {
  value = "${azurerm_subnet.sb.2.name}"
}

output "subnet_data_name" {
  value = "${azurerm_subnet.sb.3.name}"
}

output "location" {
  value = "${azurerm_resource_group.rg.location}"
}*/

