#!/bin/bash

# Script to initialize Terraform for different environments

set -e

ENVIRONMENT=$1

if [ -z "$ENVIRONMENT" ]; then
    echo "Usage: ./terraform-init.sh <dev|staging|prod>"
    exit 1
fi

cd environments/$ENVIRONMENT

echo "Initializing Terraform for $ENVIRONMENT environment..."

# Initialize with backend configuration
terraform init \
    -backend-config="bucket=your-terraform-state-$ENVIRONMENT" \
    -backend-config="key=$ENVIRONMENT/terraform.tfstate" \
    -backend-config="region=us-east-1" \
    -backend-config="dynamodb_table=terraform-state-lock-$ENVIRONMENT" \
    -backend-config="encrypt=true"

echo "Terraform initialization complete for $ENVIRONMENT"

# Format and validate
terraform fmt
terraform validate

echo "Formatting and validation complete"
