resource "azurerm_resource_group" "azure_bootstrap_rg" {
  name     = "${var.resource_name_prefix}-${var.name_initials}-rg"
  location = var.location
  tags     = var.default_tags
}
