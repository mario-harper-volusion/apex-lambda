[ ![Codeship Status for mario-harper-volusion/apex-lambda](https://codeship.com/projects/5cd9b7d0-452e-0134-625c-460fa3f2896d/status?branch=master)](https://codeship.com/projects/168592)

## Deploy / Destroy 

### Help
```sh
bash ./deploy/run.sh --help
```

### Deploy
To deploy all of the infrastructure and lambdas for a given environment.

```sh
bash ./deploy/run.sh --env {environment}
```

### Destroy
To destroy all of the infrastructure and lambdas for a given environment.

```sh
bash ./deploy/run.sh --env {environment} --destroy
```

## Project Structure
```
PROJECT-NAME
|   project.{env}.json // lambda settings by environment [apex.run]
│
├───deploy                     // handles deploying of project
│
├───functions                   // lamda functions [apex.run]
|   └───hello            
|       |   index.js
|
└───infrastructure             // infrastructure as code [terraform]
    ├───{env}
    │   |   main.tf            // configures terraform modules defined under ../modules for this specific environment.
    │   |   outputs.tf         // defines terraform outputs
    │   |   variables.tf       // defines input variables
    │
    └───modules
        ├───api_gateway        // configures the tax API
        |
        └───iam                // configures IAM for API and Lambdas
```

