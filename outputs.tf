output "nsg_id" {
  description = "The ID of the newly created Network Security Group"
  value       = azurerm_network_security_group.nsg.id
}

output "nsg_name" {
  description = "The name of the new NSG"
  value       = azurerm_network_security_group.nsg.name
}