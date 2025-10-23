# About
Terraform scripts for spinning up resources in AWS, utilized by our CI/CD pipeline.

## Pre-requisites

1. Install terraform
2. Install the aws command line
3. Run `aws sso configure`. Choose a session name and profile name. The start URL and region come from redgate.awsapps.com
4. Go to your `.github\workflows\build\database-tests\aws` directory and run `terraform init`
5. Setup aws credentials:
    5.1 Option 1:
        - Setting up your credentials file. This can be done throught the `aws configure` wizard.
    5.2 Option 2: Using environment variables from the Access Portal
        - Set AWS_ACCESS_KEY_ID
        - Set AWS_SECRET_ACCESS_KEY
        - Set AWS_SESSION_TOKEN

## Reminders - usefull commands

```
aws rds describe-orderable-db-instance options
```
