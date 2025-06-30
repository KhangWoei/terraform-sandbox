# Azure Sql Database Pricing

## DTU-based vs vCore-based

## 1. Database transaction unit (DTU) based
DTU is a measure "blended" measure of CPU, memory, and I/O usage. This model prepackages a combination of those resources alongside storage. A lot simpler to get started with.

### 1.1 Tiers 

 Tiers    | DTUs       | Inc. Storage | Max Storage | Price $/month      |
 -------- | ---------- | ------------ | ----------- | ------------------ |
 Basic    | 5          | 2GB          | 2GB         | ~4.89              |
 Standard | 10 - 3000  | 250GB        | 250GB - 1TB | ~14.72 - 4,415.59  |
 Premium  | 125 - 4000 | 500GB - 4 TB | 1TB - 4TB   | 456.25 - 15,698.89 |

### 2. Virtual core (vCore) based
vCores represent a logical CPU. Allows a more granular choice between generations of hardware and their physical characteristics ranging from the number of cores, memory, and storage size. 

### 2.1 Tiers

TODO - Yeah it's a lot.