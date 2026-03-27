output "resource_group_name" {
  value       = azurerm_resource_group.main.name
  description = "Created resource group name"
}

output "vm_name" {
  value       = azurerm_linux_virtual_machine.main.name
  description = "Created VM name"
}

output "public_ip_address" {
  value       = azurerm_public_ip.main.ip_address
  description = "Public IP of the VM"
}

output "ssh_command" {
  value       = "ssh ${var.admin_username}@${azurerm_public_ip.main.ip_address}"
  description = "SSH command to access the VM"
}
