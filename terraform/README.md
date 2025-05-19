# Terraform Infrastructure

This directory contains Terraform code to provision AWS resources for the User Management API.

## Prerequisites

- Terraform >= 1.4.0
- AWS CLI configured (run `aws configure`)
- AWS credentials with permissions for S3, DynamoDB, VPC, EKS, RDS, S3, IAM, etc.

## Directory Structure

- provider.tf    : AWS provider and required Terraform settings
- tf-state/      : Creates remote state backend (S3 bucket & DynamoDB table)
- vpc/           : VPC, subnets, gateways (terraform-aws-modules/vpc)
- eks/           : EKS cluster and node groups (terraform-aws-modules/eks)
- rds/           : Aurora PostgreSQL cluster (terraform-aws-modules/rds-aurora)
- s3/            : Application S3 buckets (terraform-aws-modules/s3-bucket)
- services/      : Kubernetes services & addons (Ingress, cert-manager, secrets)

## Bootstrapping Remote State

1. Navigate to `tf-state/`:
   ```bash
   cd terraform/tf-state
   ```
2. Uncomment the backend 's3' block in `backend.tf`.
3. Initialize Terraform:
   ```bash
   terraform init
   ```
4. Apply to create the S3 bucket and DynamoDB table:
   ```bash
   terraform apply -auto-approve
   ```

## Deploy Core Infrastructure

For each component (vpc, eks, rds, s3), run:

```bash
cd terraform/<component>
terraform init
terraform workspace new <env> || terraform workspace select <env>
terraform plan -var='environment=<env>'
terraform apply -var='environment=<env>' -auto-approve
```

Replace `<env>` with your workspace name (e.g., dev, prod).

## Deploy Kubernetes Services

After provisioning the EKS cluster:

```bash
cd terraform/services
terraform init
terraform plan
terraform apply -auto-approve
```

Services deployed include:

- AWS Load Balancer Controller
- NGINX Ingress Controller
- cert-manager
- Kubernetes Secrets for API credentials

## Remote State Backend

Modules (except services/) use the S3 backend:

- Bucket: galactic-tf-state
- DynamoDB Table: galactic-tf-state-lock-dynamo

Ensure `tf-state/` runs first to create them.

## Variables & Outputs


- Default variables are defined in each module's `variables.tf`. Use `-var` or `*.tfvars` to override.
- Use `terraform output` to inspect key outputs (VPC IDs, subnet IDs, cluster name, endpoints, etc.).

## Troubleshooting

- Verify the S3 bucket and DynamoDB table exist for state locking.
- Ensure correct AWS IAM permissions.
- Remove `.terraform` directory to re-init if needed.

