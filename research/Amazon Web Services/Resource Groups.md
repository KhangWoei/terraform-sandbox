# Resource groups
*Resource* being a manageable item like a virtual machine, storage account, database instance ... etc.

AWS uses resource groups to organize and manage resources. It is defined as a collection of AWS resources that are all in the same AWS Region. Resource groups can beb built using:

1. Tag-based
- Membership is based on a query that specifies a list of resource types and tags
- Property of a resource, shared across the entire account.

2. AWS CloudFormation stack-based
- Membership is based on a query that specifies an AWS CloudFormation stack in the given account in a given region.

3. AWS Config-based
- Membership is determined by AWS Config rules
- Uses configuration data to identify resources that meet specific criteria

## Groups and permissions
- Permissions on resource groups apply at the account level. Roles and users sharing the account that have the correct IAM permission as the resource group creator can work with the created resource groups. 

### IAM
- Policy actions for resource groups uses `resource-groups:` prefix. 
   - Common actions:
      - 'CreateGroup'
      - 'GetGroup'
      - 'ListGroups'
      - 'UpdateGroup'
      - 'DeleteGroup'
      - 'GetGroupQuery'
      - 'ListGroupResources'
      - 'Tag'
      - 'Untag'
- Authorization can be based off tags using the `condition element` of a policy 
- No service roles
- Does not support resource-based policies

## Deleting
- Just note that it does not delete the underlying resources like in Azure.

## Cost management
- Do resource group compose the costs of all its resources?
