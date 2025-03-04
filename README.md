# DevOps Project: Deploy Python Code to AWS Lambda with Terraform and Jenkins

## Overview
This project demonstrates how to deploy a Python function to AWS Lambda using Terraform for infrastructure management and Jenkins for CI/CD automation.

## Project Structure
- **hello-python.py**: The main Python script for the AWS Lambda function.
- **hello-python.zip**: A zipped version of the Python script, required for Lambda deployment.
- **terraform.tfstate.backup**: Backup of the Terraform state file.
- **Jenkins Pipeline**: Automates deployment using Terraform.

## Prerequisites
- AWS CLI configured with access credentials.
- Terraform installed (`>= 1.0`).
- Jenkins installed and configured.
- GitHub repository for version control.

## Deployment Steps

### Step 1: Clone the Repository
```sh
git clone https://github.com/KalyanGadde/awslambda-terraform-jenkins.git
cd awslambda-terraform-jenkins
```

### Step 2: Initialize Terraform
```sh
terraform init
```

### Step 3: Plan and Apply Infrastructure
```sh
terraform plan
terraform apply -auto-approve
```
This will:
- Create an IAM role with necessary permissions.
- Deploy the Lambda function using the zipped Python script.

### Step 4: Configure Jenkins Pipeline
1. Install Jenkins and required plugins (`Pipeline`, `Terraform`, `AWS CLI`).
2. Create a new Jenkins pipeline and link it to your GitHub repository.
3. Define the pipeline script (`Jenkinsfile`):
   ```groovy
   pipeline {
       agent any
       stages {
           stage('Terraform Init') {
               steps {
                   sh 'terraform init'
               }
           }
           stage('Terraform Apply') {
               steps {
                   sh 'terraform apply -auto-approve'
               }
           }
       }
   }
   ```
4. Save and trigger the pipeline.

### Step 5: Verify Deployment
- Navigate to AWS Lambda in the AWS Console.
- Test the deployed function.

## Cleanup
To remove resources, run:
```sh
terraform destroy -auto-approve
```

## Conclusion
This project provides a fully automated deployment pipeline for AWS Lambda using Terraform and Jenkins.

