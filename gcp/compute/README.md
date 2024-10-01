# GCP Compute Instance Terraform Module

This Terraform module creates a Google Cloud Platform (GCP) Compute Instance with additional disks and network configurations.

## Features

- Creates a GCP Compute Instance
- Configures boot disk with custom image
- Attaches additional disks (optional)
- Sets up network interface with specified subnet
- Applies labels to resources
- Supports startup script
- Configures service account with cloud-platform scope

## Prerequisites

- Terraform installed (version 0.12+)
- Google Cloud SDK installed and configured
- GCP project with necessary APIs enabled (Compute Engine API, Cloud KMS API)
- (Optional) HashiCorp Vault installed and configured

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

2. Create a `terraform.tfvars` file and specify the required variables:

```hcl
project_id            = "your-project-id"
subnet_name           = "your-subnet-name"
zone                  = "your-preferred-zone"
compute_image_name    = "your-image-name"
compute_instance_name = "your-instance-name"
machine_type          = "e2-medium"
root_disk_type        = "pd-ssd"
root_disk_size        = 50
additional_disks      = [100, 200]  # Size in GB
additional_disk_type  = "ssd"
kms_key_self_link     = "your-kms-key-self-link"
```

3. Initialize Terraform:

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

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project_id | The ID of the GCP project | string | n/a | yes |
| subnet_name | The name of the subnet to use | string | n/a | yes |
| zone | The zone where resources will be created | string | n/a | yes |
| compute_image_name | The name of the compute image to use | string | n/a | yes |
| compute_instance_name | The name of the compute instance | string | n/a | yes |
| machine_type | The machine type of the compute instance | string | n/a | yes |
| root_disk_type | The type of the root disk | string | n/a | yes |
| root_disk_size | The size of the root disk in GB | number | n/a | yes |
| additional_disks | List of sizes for additional disks in GB | list(number) | [] | no |
| additional_disk_type | The type of additional disks | string | n/a | yes |
| kms_key_self_link | The self-link of the KMS key for disk encryption | string | n/a | yes |

## Outputs

1. instance_ip_address: The internal IP address of the instance
2. instance_external_ip: The external IP address of the instance (if applicable)
3. additional_disk_names: The names of the additional disks

## References
1. [google_project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project)
2. [google_compute_subnetwork](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork)
3. [google_compute_image](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_image)
4. [google_compute_instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance)
5. [google_compute_disk](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_disk)
6. [google_compute_attached_disk](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_attached_disk)

## Contributing

Contributions to improve this module are welcome. Please submit a pull request or open an issue to discuss proposed changes.