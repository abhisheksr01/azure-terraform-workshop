# Introduction 
This repository contains Terraform code for setting up a basic Azure infrastructure.

This repo has two sections:

1. bootstrap directory:

   Contains terraform code for provisioning Resource Group, Storage account, Virtual Network and associated networking resources.

2. application-infra directory: 

   Contains terraform code for provisioning a VM & associated infrastructure components for deploying a simple application.

## Setting up your workstation

- Choose your preferred IDE (VSCode or IntelliJ) and install Terraform Plugin
- Install [TFEnv](https://github.com/tfutils/tfenv) and ensure you have Terraform `1.5.0` version installed.
  It's recommended that we lock the terraform version.
  > Demo what will happen when developers uses different version of terraform cli.

## Setting Up Bootstrap Infrastructure

Bootstrap Infrastructure refers to the essential infrastructure resources that are necessary during the initial provisioning phase and ideally remains unchanged or require infrequent modifications.

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


## terraform-best-practices
An opinionated attempt to bring Terraform Best practices under a single umbrella.

### Terraform Best Practices - 101

- Use Version Control
- TF Bootstrap
- Organize Your Code
- Use Variables
- Use Output Values
- Use Modules
- Use Terraform Backend
- Use Terraform Workspaces
- Use Terraform Provider Versioning
- Plan and Apply Separately

### Advance Best Practices

- Use Terraform Modules Wisely
- Use Remote State Sharing
- Automate Workflows with CI/CD
- Implement Security Measures
- Implement Infrastructure Testing
- Implement Infrastructure Drift Detection
- Leverage Remote Execution
- Monitor and Alert on Infrastructure Changes
- Implement a Disaster Recovery Plan
- Regularly Update Terraform Versions

### Terraform Security Best Practices

- Use Least Privilege Principle
- Secure Sensitive Information
- Protect Terraform State
- Apply Regular Updates
- Validate External Modules
- Practice Pair Programming
- Enable Logging and Monitoring
- Enable Two-Factor Authentication (2FA)
- Regularly Audit and Review Resources
- Educate and Train Your Team

### Terraform Tools & Utilities

- Terraform Validate
- Terraform Graph
- Terraform fmt
- TFLint
- TFsec
- Terrascan
- Terraform Compliance
- Terraform Vulnerability scanning
- Use AWS Nuke for Ephemeral Environments
