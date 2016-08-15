#!/bin/sh

# This codeship custom script depends on:
#  - AWS_ACCESS_KEY_ID AWS account access key
#  - AWS_SECRET_ACCESS_KEY AWS account secret key
#  - AWS_REGION AWS region

set -e

# Install aws cli
pip install awscli

# Install terraform
cd /home/rof/bin
wget https://releases.hashicorp.com/terraform/0.7.0/terraform_0.7.0_linux_amd64.zip
unzip terraform_0.7.0_linux_amd64.zip
cd /home/rof/clone
terraform -v

# Install apex
cd /home/rof/bin
wget https://github.com/apex/apex/releases/download/v0.10.2/apex_linux_amd64 -O apex
chmod 755 apex
cd /home/rof/clone
apex version

# deploy lambdas