#!/bin/sh
echo -e '\n Entering codeship.sh'

# This codeship custom script depends on ENV Vars:
#  - AWS_ACCESS_KEY_ID AWS account access key
#  - AWS_SECRET_ACCESS_KEY AWS account secret key
#  - AWS_REGION AWS region
#  - ENV environment deploying to (DEV, INT, PROD)
set -e

# Install aws cli
echo -e '\n Installing AWS CLI'
pip install awscli

# Install terraform
echo -e '\n Installing Terraform'

cd /home/rof/bin
wget https://releases.hashicorp.com/terraform/0.7.0/terraform_0.7.0_linux_amd64.zip
unzip terraform_0.7.0_linux_amd64.zip
cd /home/rof/clone
terraform -v

# Install apex
echo -e '\n Installing Apex'

cd /home/rof/bin
wget https://github.com/apex/apex/releases/download/v0.10.2/apex_linux_amd64 -O apex
chmod 755 apex
cd /home/rof/clone
apex version

# deploy lambdas
echo -e '\n Deploying lambdas'
apex deploy

# ensure git is installed
echo -e '\n Ensuring Git is installed'
git version

# deploy infrastructure
echo -e '\n Deploying infrastructure'
apex infra --env $ENV get
apex infra --env $ENV plan
apex infra --env $ENV apply 

# checkin any state changes back to github
git config --global user.email "mario_harper@volusion.com"
git config --global user.name "Mario Harper"
git checkout master
git add ./infrastructure/$ENV/*
git commit -m "[skip ci] Build caused update to infrastructure state files"
git status
git push -u origin master