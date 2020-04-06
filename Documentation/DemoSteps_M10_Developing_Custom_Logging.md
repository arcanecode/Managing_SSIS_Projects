# Module 10 - Developing Custom Logging

## Demo 1 - PackageLogger table

1. Begin by showing the package logger table.
2. Explain while it is typically kept in the target database, you could also create a single databae to hold just the logs for all of your projects.
3. The columns are as follows _(Production note: Remeber as you read these pause between each column name to allow for a call out transition to apply)_:

| Column Name | Purpose |
| --- | --- |
|PackageLoggerId | Auto incrementing key, useful for sorting |
|PackageName | Name of the package being executed |
|DataFlowName | The name of the main data flow task being executed |
|SubFlowInformation | Additional info about a task |
|RuntimeEnvironment | A word like Dev, Test, or Prod |
|RowsInserted | Number of rows inserted to the target database |
|RowsUpdated | Number of rows updated in the target database |
|RowsDeleted | Number of rows deleted from the target database |
|RowsUnaffected | Number of rows read from the source, but nothing was done with them in the target |
|ExecutionBegan | Time the task began |
|ExecutionEnded | Time the task ended |
|ExecutionStatus | Text indicating the status of the task, typically Begin or Complete |

4. Also point out there are several views designed to make the PackageLogger table easier to read, but we'll look at those later. _(Production note: Place a box around the views in the solution explorer.)_

## Demo 2 - City Package Variables

1. Explain that all of our packages follow this same pattern, so we'll just look at the one package.
2. Start by looking at the variables. Many of these are used as part of our custom logging, and a few make it easier when using a template which we'll cover in a later module.
3. Here is the list of variables. _(Production note: Remeber as you read these pause between each variable name to allow for a call out transition to apply)_:

| Variable Name | Purpose |
| --- | --- |
| DataFlowName | The name of the main dataflow task. Can be updated if you have multiple data flows and want to log for each one. |
| ExecutionBegan | The time the package started |
| ExecutionEnded | The time the package completed |
| PackageName | Name of the package |
| RowsDeleted | Number of rows deleted from the target |
| RowsInserted | Number of rows inserted into the target |
| RowsUnaffected | Number of rows that were not affected in the target |
| RowsUpdated | Number of rows updated in the target |
| SqlTruncate | The truncate SQL statement used to empty the table in the target database |
| SqlUpdateSourceSystem | In this demo we execute a stored procedure in the source database to update a source database table with the rows we want to read. This is the SQL statement to run that stored procedure. |
| SubFlowInformation | Additional information we may want to add to the log |

Note in this demo we only insert rows, so three of the "Rows" variables are not used, however if we were doing a data warehouse with a type 2 dimension they would be useful. 

If you want to learn more about data warehousing, see my course [Introduction to Data Warehousing / Business Intelligence](https://app.pluralsight.com/library/courses/intro-dwbi-course-2017/table-of-contents)

If you want to learn more about SSIS design patterns for data warehousing, I have another course, [SSIS Design Patterns for Data Warehousing](https://www.pluralsight.com/courses/ssis-design-patterns-data-warehousing). Even though the course was written for SQL Server 2014, the techniques are still applicable today.

## Demo 3 - The control/data flow components

1. The first task in this package is part of the logging, _EXP - Set ExecutionBegan Time_. _(Production note: Double click to open it)_
2. It has a rather complex expression, but in reality all we are doing is extracting the year, month, day, hour, minute and second pieces of the current date and making a big string out of it. We are then assigning it to the ExecutionBegan variable. _(Production note: Click _Cancel_ to close the dialog.)__
3. The next component is the _SQL Insert App-PackageLogger for Package City_. _(Production note: Open it.)_
4. 4. Click on the SQL Statement, and use the `...` button to open it.
5. See how we are inserting a row into our package logger table.
6. The values are represented by ? marks, except for the status which is hard coded to 'Running'.
7. _(Production note: Close the query window, then click on the Parameter Mapping page.)_
8. _(Production note: Expand the Variable Name and Parameter Name columns.)_
9. The variable names are the sources for the values we are inserting.
10. The Parameter name is a number that corresponds to the question marks in the query. 0 is the first question mark, and so on.
11. The last value, the RuntimeEnvironment, comes not from a variable but from a project parameter value.
12. Note in ADO connections, we use question marks for positions in the query, and numbers for the paramter names. Other connection types use a slightly different method so be sure to reference the documentation if you use a different connection type such as OLEDB.
13. _(Production note: Close the task editor window by clicking Cancel.)_
14. The next two componets, the truncate and update, are part of the package and not part of the logging.
15. The DataFlow task has one component we should examine that contributes to the logging. _(Production note: Open it.)_
16. Note our row count task. _(Production note: Open it.)_
17. It maps to our Rows Inserted variable. If this was a more complex data flow, we may have branching that might go to the unaffected, updated, or deleted logic. If so we'd add additional row count tasks to capture that information.
18. _(Production note: Return to the main control flow.)_
19. _(Production note: Open the EXP - Set ExecutionEnded Time.)_
20. This is a mirror of the ExecutionBegan expression, converting the date/time to a long string and placing it in the ExecutionEnded variable. _(Production note: Cancel out of the dialog.)_
21. We now move to the final part of the logging, the Update App-PackageLogger task. _(Production note: Open the final SQL Task)_
22. Here, we are updating the row we inserted at the beginning of the workflow. We update the row counts, along with the execution ended time. We also update the status to complete.
23. We match based on the package name, data flow name, subflow info, and execution began time. Note if you changed the dataflow name during logging you'll need to use the orginal one here that you used when you created the record.
_(Production note: Click on the parameter mapping page.)_
24. As we did earlier, we are mapping our variables into the columsn used by the query.
25. Now let's move to look at our custom log.

## Demo 4 - Running the built in Views - Package Log Master Runs

1. _(Production note: Open SSMS, expand the target DB and the views.)_
2. The first view we will look at is the __App.PackageLogMasterRuns__. _(Production note: Do a select top 1000 on the view)_
3. This query only brings back the completed executions of the master package. It lets us know the execution time in human readable form, as well as in time format. If the query runs into minutes and hours, the human readable will expand to show xx minutes xx seconds, etc.
4. It will also show the exact start and end times.
5. Note there is a similar view, __App.PackageLogMasterRunsToday__, which only returns master package executions since midnight.

## Demo 5 - Running the built in Views - Package Log Today

1. _(Production note: Run the PackageLogToday view. Scroll to the bottom.)_
2. This view brings back all data since midnight. It will show each package, it's run times, results, and the like.
3. From the master package, you see it included additional data such as the path begin / end times. 

Point out the big advantage to doing a custom log in addition to the built in logging is that your custom logging will work even if the package is executed inside your Visual Studio development, as opposed to the SSIS logging which only works when the package is executed from the catalog.

## Up Next

While it may seem like setting up custom logging is extra work, you can make it go much easier by creating a package template with the logging components already established.

In the next module, we'll see how to setup and use a template for your own projects.

