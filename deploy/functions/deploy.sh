deploy(){

  # deploy infrastructure
  echo -e  "\nDeploying infrastructure in "$ENVIRONMENT
  apex infra --env $ENVIRONMENT get
  apex infra --env $ENVIRONMENT plan
  if apex infra --env $ENVIRONMENT apply; then
    echo -e  "\nTerraform apply success"
  else
    echo -e  "\n${RED}Exiting because of failed terraform apply.${NC}"
    exit 1
  fi

  # deploy the lambdas
  echo -e  "\nDeploying lambdas to "$ENVIRONMENT
  apex deploy --env $ENVIRONMENT


  echo -e  "\nSuccessfully deployed "$ENVIRONMENT

  return 0
  
}