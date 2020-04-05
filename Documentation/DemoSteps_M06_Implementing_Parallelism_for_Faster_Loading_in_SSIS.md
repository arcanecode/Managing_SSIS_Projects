# Module 6 - Implementing Parallelism for Faster Loading in SSIS

## Demo 1 - Open with Master.dtsx

1. Explain the method is to use a package to run other packages. 
2. Some of the objects here are to support custom logging, which we will cover more in a later module. 
3. For example, the first two get the package start time and write it to our custom log. 
4. The real part of paralellism begins with the SQL Path 1/2 Queue tasks. Let's look at the table that drives this.

## Demo 2 - The Table

1. In the package, explain the SQL - Path 1 Queue is fed from a variable.
2. Show the variable sqlPackageRunner_Path1 in the Variables area.

```sql
select [PackageName], [Parameter] from [App].[PackageRunner] where [LoadPath] = 1 and [RunPackage] = 'Y' order by [LoadOrder]
```

3. Explain it will get packages from the PackageRunner table where it should run in path 1, and the run package status is yes. Using a RunPackage flag will allow us to enable and disable packages from running easily without having to delete rows from the table.
4. Switch to the App.PackageRunnerInitialLoad stored procedure.
5. Explain how it works.
6. Return to the master package.

## Demo 3 - Back to the Master Package

### Demo 3.1 - The SQL Task

1. Open the SQL task
2. Point out the Result Set is set to full result set
3. Click on the Result Set tab.
4. Show how it is assigned to the variable path1_Runner, which is of type Object.
5. Close the Sql Task Editor

### Demo 3.2 - The ForEach Loop Container

1. Open the For Each Loop Container
2. Click on Collection
3. The Enumerator is Foreach ADO Enumerator
4. The ADO Object Source Variable is set to the path1_Runner object variable we retrieved in the Execute SQL Task
5. We are using all rows in the first table
6. Click on Variable Mappings
7. The first column in the result set, column 0, is placed in the path1_PackageName variable.
8. The second column, column 1, is copied into the path1_Parameter
9. Click cancel to close the FELC

### Demo 3.3 - Execute SQL Task (in FELC)

1. Explain the SQL task is for custom logging, more on that later.

### Demo 3.4 - Execute Package Task

1. Open the Execute Package Task
2. Click on the Package tab
3. Reference type is Project Reference, another package in this project
4. When the EPT is created, you have to have a package for it to reference. Hence we have an empty package called PackageRunnerPlaceHolder.dtsx. If you open the package it is empty, it doesn't actually do anything but allow us to use the EPT and replace the name of the package to run at execution time.
5. Click on the Expressions tab.
6. Click the arrow beside Expressions to expand it.
7. Show how the PackageName is repalced with the path1_PackageName variable.
8. Click Cancel to close

### Demo 3.5 - Remaining Logging Tasks

1. The remaining two tasks in the FELC are for logging, they will note when a package is done running.

## Demo 4 - After FELC in Path 1

1. The two tasks just after the EPT log that is has completed running Path 1.

## Demo 5 - Paths Merge

1. Finally both paths merge into tasks which log the package has completed running.

## Demo 6 - Run the package

1. Switch to SSMS
2. Navigate to the Master package
3. Execute it
4. After it runs, say OK to open the overview report
5. In the report, show each package executed in the list
