terraform {
  required_version = "1.5.0"
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.2"
    }
    null = {
      source  = "hashicorp/null"
      version = "=3.2.1"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
    virtual_machine {
      delete_os_disk_on_deletion = true
      graceful_shutdown          = false
    }

    resource_group {
      prevent_deletion_if_contains_resources = false
    }

  }
  subscription_id = var.subscription_id
}
