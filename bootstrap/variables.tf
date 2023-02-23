variable "subscription_id" {
  type = string
}

variable "resource_name_prefix" {
  type = string
}

variable "infrabackend_storage_account_name" {
  type = string
}

variable "infrabackend_storage_account_container_names" {
  type = set(string)
}

variable "storage_account_account_tier" {
  type = string
}

variable "storage_account_replication_type" {
  type = string
}

variable "location" {
  type = string
}

# Tags
variable "default_tags" {
  type = object({
    Owner       = string
    Team        = string
    Description = string
    Environment = string
    Provisioner = string
    CostCode    = string
  })
  default = {
    Owner       = "Abhishek"
    Team        = "Azure Terraform Learning - abhisheksr01"
    Description = "Resources for Azure Terraform Learning"
    Environment = "Dev"
    Provisioner = "Terraform"
    CostCode    = "100-101" # Random value very useful for billing purposes.
  }
}