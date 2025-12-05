# AWS CloudFormation One-Pager Stack

This directory contains the CloudFormation template and helper scripts that spin up a minimal AWS footprint for hosting the local `index.html` file on a single EC2 instance.

## What gets created

- Dedicated VPC, public subnet, internet gateway, and routing.
- Security group that allows HTTP/HTTPS/SSH from `AllowedCidr`.
- Amazon Linux 2023 EC2 instance running nginx with the checked-in `index.html`.
- IAM role/profile with SSM access so you can connect via Session Manager instead of SSH keys.

## Prerequisites

- AWS CLI v2 configured with credentials authorized to create IAM + EC2 + networking resources.
- (Optional) Existing EC2 KeyPair if you prefer SSH; set `KEY_PAIR_NAME`.

## Deploy with AWS CLI

```bash
export AWS_REGION=eu-west-1
export STACK_NAME=sa-tech-scenario-2-cl
# Optional overrides:
# export ALLOWED_CIDR=203.0.113.0/24

./scripts/aws-onepager-deploy.sh
```

Once the deploy finishes, the script prints the stack outputs including the public URL. Open the `WebsiteURL` value in a browser to view the page.

## Updating the HTML

The template inlines the repository's `index.html`. When you change that file, you must first destroy the stack by running `./scripts/aws-onepager-destroy.sh` and then re-run `./scripts/aws-onepager-deploy.sh`. This is the only way for CloudFormation to replace the user data on the instance.

## Teardown

```bash
./scripts/aws-onepager-destroy.sh
```

The destroy script deletes the CloudFormation stack and waits until all resources are removed.
