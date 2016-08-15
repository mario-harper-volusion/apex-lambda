[ ![Codeship Status for mario-harper-volusion/apex-lambda](https://codeship.com/projects/5cd9b7d0-452e-0134-625c-460fa3f2896d/status?branch=master)](https://codeship.com/projects/168592)

## AWS
Both Apex and Terraform will require setting up and configuring the AWS CLI if you want to run them locally.
[Configure AWS CLI](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#cli-quick-configuration)

In the setup you should have setup your credentials. If not set them via Environment Variables.
```sh
export AWS_ACCESS_KEY_ID=<access_key_id>
export AWS_SECRET_ACCESS_KEY=<secret_access_key>
export AWS_REGION=<region>
```
## Lambda Management (via [Apex.run](http://apex.run))
### Deploy Lambdas
```sh
apex deploy --dry-run # dry run to view what will happen
apex deploy
```

## Infrastructure as Code (via [Terraform](https://www.terraform.io/docs/index.html))
### Deploy Infrastructure
First, configure aws credentials to use [Configure AWS CLI](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#cli-quick-configuration)

Then,
```sh
apex infra --env <env> get   # binds terrform modules
apex infra --env <env> plan  
apex infra --env <env> apply 
```

## Project Structure 
DELETE terraform.tfstate and terraform.tfstate.backup if using this project as a skeleton
```
PROJECT
│   README.md
│   .gitignore 
|   project.json // globals for lambdas [apex.run]
│
├───functions   // lamda functions [apex.run]
|   └───hello
|       |   index.js
|
└───infrastructure                // infrastructure as code [terraform]
    │   main.tf                   // main terraform entry, uses modules defined under /modules
    │   terraform.tfstate         // current terraform state
    │   terraform.tfstate.backup  // backup of terraform state for rollbacks
    │   variables.tf
    │
    └───modules
        ├───api_gateway
        |   |   api_gateway_body_mapping.template
        |   |   main.tf
        |   |   variables.tf
        |
        └───iam
            |   api-gateway-iam.tf
            |   lambda-iam.tf
            |   outputs.tf
```

