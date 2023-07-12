resource "azurerm_storage_account" "infrabackend" {
  name                     = "${var.infrabackend_storage_account_name}${random_id.storage_account_name_unique.hex}"
  resource_group_name      = azurerm_resource_group.app_rg.name
  location                 = azurerm_resource_group.app_rg.location
  account_tier             = var.storage_account_account_tier
  account_replication_type = var.storage_account_replication_type

  tags = var.default_tags
}

resource "azurerm_storage_container" "infrabackend" {
  for_each              = var.infrabackend_storage_account_container_names
  name                  = each.key
  storage_account_name  = azurerm_storage_account.infrabackend.name
  container_access_type = "private"
}

resource "random_id" "storage_account_name_unique" {
  byte_length = 1
}