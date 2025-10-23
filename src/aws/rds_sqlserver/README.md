# About
Responsible for spinning up a Relational Database Service for SqlServer on AWS. This expects a vpc to already be set-up

## Pre-requisites
- A virtual private cloud to be created on the requested region with subnets across 2 availability zones. You can do this manually or by running the VPC module.

# Inputs
## Profile
`optional` Which aws profile to use. Follow the `aws configure` wizard on the CLI to create one. Defaults to `default`.

## Region
`optional` Which region to use. Defaults to `eu-west-1`

## VPC Id
`optional`While this is optional, you should pass one in if you're trying to run this locally unless your default vpc is correctly set-up. Otherwise, run the VPC module.

## Admin details
`optional` Login details for the database instance.

### Example / Default
```
admin_details =
{
    username="awsadmin",
    password=null
}
```

If password is null, it will auto-generate the password.

# Outputs

## Connection string
The connection string to the database instance.

```
terraform output --raw connection_string
```

In the Test Runner settings in your IDE, this connection string can be put in an environment variable for `REDGATE_TESTDATABASE_SQLSERVERONAWS`.
Setting the test database type to `SQLSERVERONAWS` will then set the tests to run on this test database.
