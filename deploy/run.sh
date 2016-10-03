#!/bin/bash

set -e

readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(readlink -m $(dirname $0))
readonly ARGS="$@"
readonly PROJ_NAME="apex-lambda"

# echo colors
readonly GREEN="\033[1;32m"
readonly RED="\033[1;31m"
readonly NC="\033[0m" # No Color

source ${BASH_SOURCE%/*}/functions/cmdline.sh
source ${BASH_SOURCE%/*}/functions/setTfVars.sh
source ${BASH_SOURCE%/*}/functions/installDependencies.sh
source ${BASH_SOURCE%/*}/functions/configureRemoteState.sh
source ${BASH_SOURCE%/*}/functions/deploy.sh
source ${BASH_SOURCE%/*}/functions/destroy.sh

main(){
  
  cmdline $ARGS
  installDependencies
  readonly AWS_ACCOUNT_ID=$(aws sts get-caller-identity --output text --query Account)
  echo -e "${GREEN}Using AWS Account ID: "$AWS_ACCOUNT_ID"${NC}"
  setTfVars
  configureRemoteState

  if [[ $DESTROY = 1 ]]; then
    destroy
  else
    deploy
  fi

  return 0

}

main 

