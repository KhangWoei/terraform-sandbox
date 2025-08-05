# Virtual Private Cloud (VPC)
- A logically isolated virtual network within AWS providing full control over the networking environment such as adding subnets, gateways, route tables ... etc

## Concepts
### 1. [Subnets](https://en.wikipedia.org/wiki/Subnet)
- Logical subdivision of an IP network. Essentially designating some high-order bits from the host part as part of the "network" prefix. 
- Benefits:
    - Isolates network segments 
    - Reduces congestion and so performance and speed as we ensure traffic destined for a subnet stays in said subnet, and deals with broadcast packets.

#### 1.1 Classless inter-domain routing
- Describing IP address ranges usinga compact notation
- `IP_ADDRESS/PREFIX_LENGTH`, where `PREFIX_LENGTH`indicates how many bits are "fixed", being reserved for the network portion.
- Often 1.0.x.x are public IP address and 10.0.x.x (RFC 1918) are private and is safe to be used internally, hence `10.0.0.0/16`

### 2. [Route tables](https://en.wikipedia.org/wiki/Routing_table)
- Set of rules used to determine where network traffic is directed. 
- Each subnet can have its own route table, will use the VPCs route table by default

### 3. [Internet gateway]
- Bridge between a private network to the public internet. (Two-way)
- Allows resources in public subnets to connect to the internet.
  - Subnets can be made public by adding a route that directs internet-bound traffic to the internet gateway.
- Allows resource on the internet to initiate connection to a resources.
- Resources *need* a public IP address for inbound internet connectivity.

### 4. [NAT Gateway](https://en.wikipedia.org/wiki/Network_address_translation)
- Network Address Translation service.
- Allows private subnets to connect to the internet or services outside of the VPC. (One-way, outbound only)
- Does not allow resources on the internet or outsdie of the VPC from initiating connection to a resource.

### 5. [Security Groups](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-groups.html)
- Controls traffic that is allowed to reach and leave resources associated with it. Something like authorizing what kind of traffic goes in and out of a VPC whereas 3. and 4. is whether traffic can go in or out of a VPC to begin with. 
- Allow rules only.
- Controls traffic at the instance level.
- Virtual firewall.

### 6. [Network access control list](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html)
- A security group but at the subnet level.
- Supports allow and deny rules.


