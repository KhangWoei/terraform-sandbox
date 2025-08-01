# Identity and Access Management (IAM)
- Web services that provide secure and conrolled access to AWS resources.

## Identities
- Representation of an entity that can authenticated to interact with AWS services and resources.
    - Basicallay "who" is trying to access an AWS resources (*Authentication*)
        - Identities can be:
            - IAM users
            - IAM roles
            - Root user
            - Federated users
            - AWS services
- Each AWS account has a `root user` identity that has complete access to all AWS service and resources in that account

## Access management (This principal v identity is double confusing)
- Authentication in AWS is provided by matching the sign-in credentials (an identity I guess?)to a principal, after they are authenticated a request is made to grant the principal access to resources.
    - A principal is an entity that can be *granted* permission in a policy - so "who" are we giving access to and can be: (*Authorization*)
        - AWS account IDs
        - IAM users
        - IAM roles
        - AWS service
        - Federated users
        - Anonymous users
- So, when selecting a service an authorization request is sent to that services and it looks to see if the identity trying to access it is on the list of authorized users. 

## Service availablity
- Like many AWS services, IAM is eventually consistent. It achieves high availablity by replicating data across multiple servers within Amazon's data centers. This can take some time. t
