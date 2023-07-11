resource "azurerm_resource_group" "app_rg" {
  name     = "${var.resource_name_prefix}-app-rg"
  location = var.location
  tags     = var.default_tags
}
