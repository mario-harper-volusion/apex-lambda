installDependencies(){

  # AWS CLI
  echo -e '\nVerify AWS'
  type aws >/dev/null 2>&1 || {
    echo >&2 -e '\nInstalling AWS CLI';
    pip install awscli;
    aws --version;
  }

  # TERRAFORM
  echo -e '\nVerify terraform'
  type terraform >/dev/null 2>&1 || {
    echo >&2 -e '\nInstalling Terraform';
    wget https://releases.hashicorp.com/terraform/0.7.3/terraform_0.7.3_linux_amd64.zip -O terraform.zip;
    unzip terraform.zip -d ~/bin;
    terraform version;
  }

  # APEX
  echo -e '\nVerify apex'
  type apex >/dev/null 2>&1 || {
    echo >&2 -e '\nInstalling apex';
    wget https://github.com/apex/apex/releases/download/v0.10.3/apex_linux_amd64 -O ~/bin/apex;
    chmod 755 ~/bin/apex;
    apex version;
  }

  return 0
  
}