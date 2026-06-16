# Terraform Website Deployment

This repository contains a Terraform project that deploys a simple website page on AWS using reusable modules.

## Project Overview

The Terraform configuration provisions the following AWS resources:

- VPC with public subnets and an internet gateway
- Security groups for the application load balancer and web servers
- Application Load Balancer (ALB)
- Auto Scaling Group (ASG) with Launch Template
- S3 bucket backend for Terraform state
- EC2 key pair management

The website content is served from EC2 instances behind an ALB, using a template-based page deployment.

## Repository Structure

- `main.tf` - root module wiring all child modules together
- `providers.tf` - AWS provider configuration
- `backend.tf` - S3 backend configuration for Terraform state
- `variables.tf` - root-level variables
- `outputs.tf` - root-level outputs
- `modules/`
  - `networking/` - VPC, public subnets, IGW, and route table
  - `security/` - security groups for the ALB and web servers
  - `load_balancer/` - ALB, target group, and listener
  - `asg/` - Launch template, Auto Scaling Group, and scaling policy
  - `keypair/` - SSH key pair configuration
  - `s3/` - S3 bucket resource definition

## Prerequisites

- Terraform installed
- AWS CLI installed and configured with credentials
- AWS account with permission to create VPCs, EC2, ALB, Auto Scaling, S3, IAM key pairs, and related resources

## Configuration

Update `terraform.tfvars` or provide values via `-var` when running Terraform.

### Required variables

- `bucket_name` - S3 bucket name used for Terraform state storage
- `public_subnets_cidr` - list of public subnet CIDR blocks
- `azs` - list of availability zones
- `public_key_path` - path to your SSH public key file

### Optional variables (with defaults)

- `vpc_cidr` - default: `10.0.0.0/16`
- `ami_id` - default: `ami-0b6d9d3d33ba97d99`
- `instance_type` - default: `t2.micro`
- `key_name` - default: `web-app-key`
- `app_port` - default: `5000`

> Note: The default `ssh_my_ip` value is currently hardcoded in the root variables and security module. Update this to your own IP if you want SSH access to web instances.

## Usage

1. Change into the `terraform-web-app` directory:

```bash
cd terraform-web-app
```

2. Initialize Terraform:

```bash
terraform init
```

3. Review the planned changes:

```bash
terraform plan
```

4. Apply the deployment:

```bash
terraform apply
```

5. Destroy the infrastructure when finished:

```bash
terraform destroy
```

## Outputs

- `alb_dns_name` - DNS name of the deployed Application Load Balancer

## Website Application

The website application in `app/app.py` serves a simple templated web page on port 80.

## Notes

- The Terraform backend is configured to use an S3 bucket in `us-east-1` with locking enabled.
- The project uses an AWS provider region set to `us-east-1`.
- The Auto Scaling Group is configured with a desired capacity of 2 instances, minimum 1, and maximum 5.
- Health checks are defined for the ALB target group and Auto Scaling Group.

## Recommended Improvements

- Parameterize the hardcoded SSH CIDR and move it to a variable used consistently across modules.
- Add AMI selection logic or use a data source instead of a fixed AMI ID.
- Add a launch script or user-data bootstrap to install Flask and run the app on each EC2 instance.
