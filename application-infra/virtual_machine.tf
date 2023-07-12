data "azurerm_resource_group" "azure_terraform_workshop_rg" {
  name = "${var.resource_name_prefix}-app-rg"
}

data "azurerm_network_interface" "my_terraform_nic" {
  name                = "${var.resource_name_prefix}-nic"
  resource_group_name = data.azurerm_resource_group.azure_terraform_workshop_rg.name
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                            = "abhishek_demo_vm"
  location                        = data.azurerm_resource_group.azure_terraform_workshop_rg.location
  resource_group_name             = data.azurerm_resource_group.azure_terraform_workshop_rg.name
  network_interface_ids           = [data.azurerm_network_interface.my_terraform_nic.id]
  size                            = "Standard_DS1_v2"
  computer_name                   = "HUKHANQQ2"
  admin_username                  = "hukadmin"
  admin_password                  = "Password1234"
  disable_password_authentication = false

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "22.04.202302140"
  }

  os_disk {
    name                 = "hukhanqq2_osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  tags = var.default_tags

}

resource "azurerm_virtual_machine_extension" "linux_vm_ext" {
  name                       = "${azurerm_linux_virtual_machine.linux_vm.name}_extn"
  virtual_machine_id         = azurerm_linux_virtual_machine.linux_vm.id
  publisher                  = "Microsoft.Azure.Extensions"
  type                       = "CustomScript"
  type_handler_version       = "2.0"
  auto_upgrade_minor_version = true

  protected_settings = <<SETTINGS
  {
    "commandToExecute": "./${azurerm_storage_blob.linux_cse_blob.name}",
    "fileUris": ["${azurerm_storage_blob.linux_cse_blob.url}"],
    "storageAccountName" : "${data.azurerm_storage_account.blobstorage.name}",
    "storageAccountKey": "${data.azurerm_storage_account.blobstorage.primary_access_key}"
  }
  SETTINGS

  tags = var.default_tags
}

resource "azurerm_storage_blob" "linux_cse_blob" {
  name                   = "linux_cse.sh"
  storage_account_name   = var.storage_account_name
  storage_container_name = "infrastructure"
  type                   = "Block"
  source                 = "./linux_cse.sh"
  content_md5            = filemd5("./linux_cse.sh")
}

data "azurerm_storage_account" "blobstorage" {
  name                = var.storage_account_name
  resource_group_name = data.azurerm_resource_group.azure_terraform_workshop_rg.name
}
