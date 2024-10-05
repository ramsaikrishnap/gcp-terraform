# GCP VPC with Multiple Subnets Terraform Module

This Terraform module creates a Virtual Private Cloud (VPC) in Google Cloud Platform (GCP) with multiple subnets, including both public and private subnets across different regions.

## Features

- Creates a custom VPC in GCP
- Supports multiple subnets (both public and private)
- Allows subnet creation across different regions
- Sets up Cloud Router and Cloud NAT for public subnets
- Enables private Google access for private subnets

## Prerequisites

- Terraform 0.12+
- Google Cloud Platform account
- GCP project with billing enabled
- Appropriate permissions to create networking resources in GCP

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
   - Modify the VPC name if desired
   - Adjust the subnet configurations as needed

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

- `main.tf`: Contains the main Terraform configuration for creating the VPC, subnets, Cloud Router, and Cloud NAT.
- `variables.tf`: Defines the input variables for the module.
- `outputs.tf`: Specifies the outputs that will be displayed after applying the Terraform configuration.
- `terraform.tfvars`: Contains the actual values for the variables. Modify this file to customize your deployment.

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project_id | The ID of the GCP project | string | n/a | yes |
| region | The region to create resources in | string | n/a | yes |
| vpc_name | The name of the VPC | string | n/a | yes |
| subnets | A map of subnet configurations | map(object) | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | The ID of the created VPC |
| vpc_name | The name of the created VPC |
| subnets | A map of the created subnets with their details |

## Subnet Configuration

Each subnet in the `subnets` variable should have the following attributes:

- `cidr_range`: The IP range for the subnet in CIDR notation
- `region`: The GCP region where the subnet will be created
- `private`: Boolean flag indicating if the subnet is private (true) or public (false)

## Notes

- Public subnets will have a Cloud Router and Cloud NAT set up automatically.
- Private subnets will have private Google access enabled.
- Modify the `terraform.tfvars` file to add, remove, or modify subnets as needed.

## Outputs

1. VPC Id: The ID of the created VPC 
2. VPC Name: The name of the created VPC
3. Subnets List: A map of the created subnets 

## References
1. [google_compute_network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network)
2. [google_compute_subnetwork](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork)
3. [google_compute_router](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_router)
4. [google_compute_router_nat](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat)

## Contributing

Feel free to submit issues or pull requests if you have suggestions for improvements or find any bugs.

