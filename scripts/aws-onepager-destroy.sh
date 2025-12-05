#!/usr/bin/env bash
set -euo pipefail

STACK_NAME="${STACK_NAME:-sa-tech-scenario-2-cl}"
REGION="${AWS_REGION:-eu-west-1}"

echo "Deleting CloudFormation stack '${STACK_NAME}' in region '${REGION}'"
aws cloudformation delete-stack \
    --region "${REGION}" \
    --stack-name "${STACK_NAME}"

echo "Waiting for stack deletion to finish..."
aws cloudformation wait stack-delete-complete \
    --region "${REGION}" \
    --stack-name "${STACK_NAME}"

echo "Stack '${STACK_NAME}' deleted."
