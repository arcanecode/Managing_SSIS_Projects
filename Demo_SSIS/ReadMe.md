# Demo_SSIS

The SSIS project is the core of the demos. There are two connection managers. Both are set to use localhost as the server, and connect to either the SourceDB or TargetDB_Dev. 

There are two package parts, which are discussed in module 12.

There are a number of packages. Some are just used to load data in order to demonstrate parallel package execution. Others demonstrate the custom logging, package parts, and the like.

|Package Name|Purpose|
|---|---|
|City|Loads City Data, serves as a longer running package|
|Employee|A simplified version of the load employee package|
|EmployeePP|The employee package implemented with package parts|
|EmployeeV2|A version of the employee package that includes custom logging|
|Master|The master package for implementing package parallelism|
|PackageRunnerPlaceHolder|As explained in the module on parallel package execution, serves as a place holder for the execute package task components|
|Payment Method|A package to load payment data|
|Template|The package we will use as our template|
|TransactionType|A package to load transaction type data|

You can reference the [Read Me](Documentation/ReadMe.md) file in the Documentation folder for more information.

## Author Information

### Author

Robert C. Cain | @ArcaneCode | arcanecode@gmail.com 

### Websites

Main Site: [http://arcanecode.me](http://arcanecode.me)

Github: [http://arcanecode.gallery](http://arcanecode.gallery)

### Copyright Notice

This document is Copyright (c) 2019, 2020 Robert C. Cain. All rights reserved.

The code samples herein is for demonstration purposes. No warranty or guarantee is implied or expressly granted.

This document, or the code samples that it accompanies, may not be reproduced in whole or in part without the express written consent of the author. Information within can be used within your own projects.
