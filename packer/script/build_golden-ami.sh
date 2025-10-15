#!/bin/bash
set -e

echo "🔹 Starting Golden AMI Build..."
packer init ubuntu-golden-ami.pkr.hcl
packer build ubuntu-golden-ami.pkr.hcl

AMI_ID=$(jq -r '.builds[-1].artifact_id | split(":")[1]' manifest.json)
echo "✅ Golden AMI built successfully: $AMI_ID"

echo "ami_id = \"$AMI_ID\"" > latest_ami.auto.tfvars

aws ssm put-parameter --name "/golden-ami/latest" --value "$AMI_ID" --type "String" --overwrite

echo "✅ AMI ID stored in SSM Parameter Store as /golden-ami/latest"

