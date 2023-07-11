terraform {
  required_version = "1.5.0"
  # backend "azurerm" {
  #   resource_group_name  = "abhishek_bootstrap_rg"
  #   storage_account_name = "abhishekdemo"
  #   container_name       = "infrastructure"
  #   key                  = "terraform.tfstate"
  # }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.2"
    }
    null = {
      source  = "hashicorp/null"
      version = "=3.2.1"
    }
    template = "~> 2.0"
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
