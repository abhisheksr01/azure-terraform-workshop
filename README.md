# Introduction 
This repository contains Terraform code for setting up a basic Azure infrastructure.

This repo has two sections:

1. bootstrap directory:

   Contains terraform code for provisioning Resource Group, Storage account, Virtual Network and associated networking resources.

2. application-infra directory: 

   Contains terraform code for provisioning a VM & associated infra components for deploying a simple application.

## Setting Up Bootstrap Infrastructure

Bootstrap Infrastructure refers to the essential infrastructure resources that are necessary during the initial provisioning phase and ideally remain unchanged or require infrequent modifications.

### What resources are considered as Bootstrap?

In case of Azure where we already have a subscription and a user to provision the initial resources we may consider Resource Group, Storage Account and Service Principle as the bare minimal resources.

In cases where the Software Engineer Team relies on provisioning this bootstrap infrastructure provisioning of Virtual Network and associated networking resources can also be considered as bootstrap infrastructure where hardening of the network is managed by SMEs.


### Provisioning Bootstrap Infrastructure

- From the terminal change the directory
  ```bash
  cd bootstrap
  ```

- Initialize Terraform
  ```bash
  terraform init
  ```

- Plan the Terraform changes and review
  ```bash
  terraform plan
  ```

- Apply changes after its reviewed
  ```bash
  terraform apply
  ```

- Update backend-config.hcl
  Take a note of the newly created storage in the console output shown as `azurerm_backend_storage_account = aztfworkshopsaXX`.

  Open [./bootstrap/backend-config.hcl](./bootstrap/backend-config.hcl) file and replace storage account name `storage_account_name = "aztfworkshopsa65"` to what we have taken note above.

- Re Initialize Terraform to use a remote backend
  
  Uncomment `# backend "azurerm" {}` at line number 3 in the [./bootstrap/main.tf](./bootstrap/main.tf) file.

  Then execute below command and when prompted respond as `yes`:

  ```bash
  terraform init -backend-config=./backend-config.hcl 
  ```

  Once successfully executed the local `terraform.state` file has been securely stored in the Azure Storage Account.


### Provisioning Application Infrastructure

In our scenario we would like to provision a small Ubuntu VM and using the `azurerm_virtual_machine_extension` deploy a [Hello World Python Application](https://github.com/abhisheksr01/zero-2-hero-python-flask-microservice) to our newly created VM.

- From the terminal change the directory
  ```bash
  cd application-infra
  ```

- Update backend-config.hcl
  Open [./application-infra/backend-config.hcl](./application-infra/backend-config.hcl) file and replace storage account name `storage_account_name = "aztfworkshopsa65"` to what we have taken note.

- Initialize Terraform
  ```bash
  terraform init -backend-config=./backend-config.hcl
  ```

- Plan the Terraform changes and review
  ```bash
  terraform plan
  ```

- Apply changes after its reviewed
  ```bash
  terraform apply
  ```

  Once successfully executed you will see an `application_public_url` in the console output. Use the URL to access the application deployed in your newly provisioned VM.

> Note: If you are running behind a Corporate proxy, VPN or firewall it's highly likely that access to the IP based URL's might be blocked.