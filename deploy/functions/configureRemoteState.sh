configureRemoteState(){

  apex infra --env $ENVIRONMENT remote config -backend=s3 \
    -backend-config="bucket=volusion-terraform-state-"$ENVIRONMENT \
    -backend-config="key="$PROJ_NAME"/terraform.tfstate" \
    -backend-config="region="$AWS_REGION

  return 0

}