output "website_url" {
  description = "HTTP URL for the one-pager."
  value       = "http://${azurerm_public_ip.this.ip_address}"
}

output "public_ip" {
  description = "Public IPv4 address of the VM."
  value       = azurerm_public_ip.this.ip_address
}

output "vm_id" {
  description = "ID of the Linux VM."
  value       = azurerm_linux_virtual_machine.this.id
}

output "subnet_id" {
  description = "ID of the subnet."
  value       = azurerm_subnet.this.id
}
