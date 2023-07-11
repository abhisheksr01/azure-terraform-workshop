output "vm_public_ip" {
    value = azurerm_linux_virtual_machine.linux_vm.public_ip_address
}