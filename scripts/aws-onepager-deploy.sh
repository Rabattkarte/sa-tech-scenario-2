#!/usr/bin/env bash
set -euo pipefail

STACK_NAME="${STACK_NAME:-sa-tech-scenario-2-cf}"
IDENTIFIER="${IDENTIFIER:-$STACK_NAME}"
TEMPLATE_PATH="${TEMPLATE_PATH:-$(dirname "$(dirname "$0")")/aws-cloudformation-onepager/ec2-onepager.yml}"
REGION="${AWS_REGION:-eu-west-1}"
INSTANCE_TYPE="${INSTANCE_TYPE:-t3.micro}"
ALLOWED_CIDR="${ALLOWED_CIDR:-0.0.0.0/0}"
KEY_PAIR_NAME="${KEY_PAIR_NAME:-}"
VPC_CIDR="${VPC_CIDR:-10.42.0.0/24}"
PUBLIC_SUBNET_CIDR="${PUBLIC_SUBNET_CIDR:-10.42.0.0/25}"
AMI_PARAM="${AMI_PARAM:-/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64}"

echo "Deploying stack '${STACK_NAME}' in region '${REGION}' using template ${TEMPLATE_PATH}"

aws cloudformation deploy \
    --stack-name "${STACK_NAME}" \
    --region "${REGION}" \
    --template-file "${TEMPLATE_PATH}" \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides \
    Identifier="${IDENTIFIER}" \
    InstanceType="${INSTANCE_TYPE}" \
    AllowedCidr="${ALLOWED_CIDR}" \
    KeyPairName="${KEY_PAIR_NAME}" \
    VpcCidr="${VPC_CIDR}" \
    PublicSubnetCidr="${PUBLIC_SUBNET_CIDR}" \
    AmiIdParameter="${AMI_PARAM}"

echo
echo "Deployment finished. Current stack outputs:"
aws cloudformation describe-stacks \
    --region "${REGION}" \
    --stack-name "${STACK_NAME}" \
    --query "Stacks[0].Outputs" \
    --no-cli-pager
