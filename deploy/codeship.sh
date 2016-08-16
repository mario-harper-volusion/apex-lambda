#!/bin/sh
echo -e '\n Entering codeship.sh'

# This codeship custom script depends on ENV Vars:
#  - AWS_ACCESS_KEY_ID AWS account access key
#  - AWS_SECRET_ACCESS_KEY AWS account secret key
#  - AWS_REGION AWS region
#  - ENV environment deploying to (dev, int, prod)
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

# echo out tfstates just in case git fails to check them back in.
echo -e '\n CONENTS OF: /infrastructure/'$ENV'/terraform.tfstate'
cat ./infrastructure/$ENV/terraform.tfstate
echo -e '\n CONENTS OF: /infrastructure/'$ENV'/terraform.tfstate.backup'
cat ./infrastructure/$ENV/terraform.tfstate.backup

# check in any state changes back to github
echo -e '\n Checking in any terraform state changes to github'
git config --global user.email "mario_harper@volusion.com"
git config --global user.name "Mario Harper"
git checkout master
git add ./infrastructure/$ENV/*
# "[skip ci]" on commit comment prevents CI/CD loop
git commit -m "[skip ci] Build caused update to infrastructure state files" || [ echo "GIT STATUS: No changes to commit" && exit 0 ]
echo -e '\n GIT STATUS: Pre git push'
git status
git push -u origin master
echo -e '\n GIT STATUS: Post git push'
git status