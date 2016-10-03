destroy(){

  # destroy the lambdas
  echo -e  "\nDestroying lambdas in "$ENVIRONMENT
  apex delete -f --env $ENVIRONMENT

  # destroy infrastructure
  echo -e  "\nDestroying infrastructure in "$ENVIRONMENT
  apex infra --env $ENVIRONMENT get
  apex infra --env $ENVIRONMENT plan -destroy
  apex infra --env $ENVIRONMENT destroy --force

  echo -e  "\nSuccessfully destroyed "$ENVIRONMENT

  return 0

}
