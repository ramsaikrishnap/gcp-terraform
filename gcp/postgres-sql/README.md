# GCP Postgres SQL Database Creation Terraform Module

This Terraform module creates PostgreSQL databases in Google Cloud Platform (GCP).

## Features

- Creates PostgreSQL database instances
- Supports high availability configuration
- Allows creation of read replicas
- Configurable instance tiers and storage sizes
- Enables automatic backups

## Prerequisites

- Terraform 0.12+
- Google Cloud Platform account
- GCP project with billing enabled
- Appropriate permissions to create database resources in GCP

## Authentication

To authenticate the Google provider, you have several options:

1. Use Application Default Credentials:
   ```
   gcloud auth application-default login
   ```

2. Use a Service Account key file:
   - Create a service account and download its JSON key file
   - Set the `GOOGLE_APPLICATION_CREDENTIALS` environment variable:
     ```
     export GOOGLE_APPLICATION_CREDENTIALS="/path/to/your/service-account-key.json"
     ```

3. Specify credentials in the provider block:
   ```hcl
   provider "google" {
     credentials = file("/path/to/your/service-account-key.json")
     project     = var.project_id
     region      = var.region
   }
   ```

4. Use HashiCorp Vault for authentication:
   - Ensure Vault is installed and configured with GCP secrets engine
   - Add the following to your Terraform configuration:

   ```hcl
   provider "vault" {}

   data "vault_generic_secret" "gcp_creds" {
     path = "gcp/token/my-role"
   }

   provider "google" {
     project = var.project_id
     region  = var.region
     access_token = data.vault_generic_secret.gcp_creds.data["token"]
   }
   ```

   - Configure Vault GCP secrets engine:
     ```
     vault secrets enable gcp
     vault write gcp/config credentials=@/path/to/your/service-account-key.json
     vault write gcp/roleset/my-role project="your-project-id" secret_type="access_token" token_scopes="https://www.googleapis.com/auth/cloud-platform"
     ```

Choose the method that best fits your security requirements and workflow.

## Usage

1. Clone this repository or copy the Terraform files to your local machine.

2. Update the `terraform.tfvars` file with your specific configurations:
   - Set your GCP project ID
   - Modify the database configurations as needed

3. Initialize the Terraform working directory:
   ```
   terraform init
   ```

4. Review the planned changes:
   ```
   terraform plan
   ```

5. Apply the Terraform configuration:
   ```
   terraform apply
   ```

6. Confirm the action by typing `yes` when prompted.

## File Structure

- `main.tf`: Contains the main Terraform configuration for creating the database instances.
- `variables.tf`: Defines the input variables for the module.
- `outputs.tf`: Specifies the outputs that will be displayed after applying the Terraform configuration.
- `terraform.tfvars`: Contains the actual values for the variables. Modify this file to customize your deployment.

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project_id | The ID of the GCP project | string | n/a | yes |
| region | The region to create resources in | string | n/a | yes |
| databases | A map of database configurations | map(object) | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| postgres_instances | A map of the created database instances with their details |
| postgres_connections | Connection details for the databases (sensitive information) |

## Database Configuration

Each database in the `databases` variable should have the following attributes:

- `type`: The type of database (POSTGRES)
- `version`: The database engine version
- `tier`: The machine type for the database instance
- `size`: The storage size in GB
- `ha`: Boolean flag indicating if high availability should be enabled
- `replicas`: Number of read replicas to create (0 for no replicas)

## Notes

- This module creates Cloud SQL instances which can incur costs. Be sure to clean up resources when they're no longer needed.
- High Availability (HA) configuration is available for all database types, but it increases costs.
- Read replicas are supported for all database types.
- Automatic backups are enabled by default.

## References

1. [google_sql_database_instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance)


## Contributing

Feel free to submit issues or pull requests if you have suggestions for improvements or find any bugs.