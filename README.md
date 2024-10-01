# GCP Terraform Project

This project uses Terraform to manage infrastructure on Google Cloud Platform (GCP).

## Table of Contents

- [Prerequisites](#prerequisites)
- [Authentication Methods](#authentication-methods)
  - [1. Google Cloud SDK](#1-google-cloud-sdk)
  - [2. Service Account Key File](#2-service-account-key-file)
  - [3. Google Cloud Workload Identity Federation](#3-google-cloud-workload-identity-federation)
  - [4. HashiCorp Vault](#4-hashicorp-vault)
- [Project Structure](#project-structure)
- [Usage](#usage)
- [Best Practices](#best-practices)

## Prerequisites

1. [Terraform](https://www.terraform.io/downloads.html) (v0.12+)
2. [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
3. A GCP Project

## Authentication Methods

There are several ways to authenticate Terraform with GCP. Choose the method that best fits your use case and security requirements.

### 1. Google Cloud SDK

This method uses your personal or service account credentials from the Google Cloud SDK.

1. Install the [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
2. Run `gcloud auth application-default login`
3. Set the project: `gcloud config set project YOUR_PROJECT_ID`

In your Terraform configuration:

```hcl
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}
```

### 2. Service Account Key File

This method uses a service account key file.

1. Create a service account in the GCP Console
2. Generate a JSON key for the service account
3. Save the JSON key file securely

In your Terraform configuration:

```hcl
provider "google" {
  credentials = file("path/to/your/service-account-key.json")
  project     = "your-project-id"
  region      = "us-central1"
}
```

### 3. Google Cloud Workload Identity Federation

This method allows you to access GCP resources without a GCP service account key.

1. Set up Workload Identity Federation in GCP
2. Configure your CI/CD platform or on-premises environment

In your Terraform configuration:

```hcl
provider "google" {
  project                     = "your-project-id"
  region                      = "us-central1"
  impersonate_service_account = "your-service-account@your-project.iam.gserviceaccount.com"
}
```

### 4. HashiCorp Vault

This method uses HashiCorp Vault to manage GCP credentials securely.

1. Set up HashiCorp Vault with the GCP secrets engine
2. Configure Vault to generate GCP service account keys

In your Terraform configuration:

```hcl
provider "vault" {
  address = "http://vault.example.com:8200"
}

data "vault_generic_secret" "gcp_credentials" {
  path = "gcp/key/my-service-account"
}

provider "google" {
  credentials = data.vault_generic_secret.gcp_credentials.data["private_key_data"]
  project     = "your-project-id"
  region      = "us-central1"
}
```

## Project Structure

```
.
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── README.md
```

## Usage

1. Initialize the Terraform working directory:
   ```
   terraform init
   ```

2. Plan the changes:
   ```
   terraform plan
   ```

3. Apply the changes:
   ```
   terraform apply
   ```

4. To destroy the resources:
   ```
   terraform destroy
   ```

## Best Practices

1. Use version control (e.g., Git) for your Terraform configurations
2. Implement remote state storage (e.g., Google Cloud Storage)
3. Use modules to organize and reuse your code
4. Always run `terraform plan` before `terraform apply`
5. Use variables and outputs to make your configurations more flexible
6. Implement state locking to prevent concurrent state operations
7. Use Terraform workspaces for managing multiple environments
8. Regularly update Terraform and provider versions

For more information, refer to the [Terraform GCP Provider Documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs) and [Google Cloud Documentation](https://cloud.google.com/docs).