# About
Responsible for spinning up a Virtual Private Cloud configured with 2 subnets across 2 different availability zones accessible to and by the public internet.

# Inputs
## Profile
`optional` Which aws profile to use. Follow the `aws configure` wizard on the CLI to create one. Defaults to `default`

## Region
`optional` Which region to use. Defaults to `eu-west-1`

# Outputs

## VPC Id
The ID of the VPC you just created

```
terraform output vpc_id
```

