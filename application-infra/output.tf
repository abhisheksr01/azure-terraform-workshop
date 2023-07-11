output "application_public_url" {
  value = "${azurerm_linux_virtual_machine.linux_vm.public_ip_address}:5000/greetings/abhishek"
}