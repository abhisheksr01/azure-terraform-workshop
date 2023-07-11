variable "subscription_id" {
  type = string
}

variable "resource_name_prefix" {
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
    Team        = "Modern Engineering Practise"
    Description = "Resources for Hachtte Lunch and learn"
    Environment = "DEMO"
    Provisioner = "Terraform"
    CostCode    = "1000-550"
  }
}
