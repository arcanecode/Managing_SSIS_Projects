# Module 5 - Using Canned Dashboard Reports

For these demos you will use SQL Server Management Studio. 

## Demo 1 - Execution Dashboard

1. Expand the Integration Services Catalogs branch.
2. Right Click on SSISDB
3. In the menu select *Reports*, then *Standard Reports*, *All Executions*.
4. Explain this is the execution dashboard, presenting a summary.
5. Show how the lines in the report are each execution of a package.

## Demo 2 - Overview Report

1. Point the operation ID, the package name, and status in the upper left.
2. Explain the Execution Overview below it.
3. Show the duration, start / end time in upper right.
4. Show Parameter info.

## Demo 3 - Messages

1. From the Overview you can click on messages, or in the Overview report.
2. Explain SSIS generates messages by which you can track the progress and status of a package execution at each step.
3. Show how you can sort the columns in the report.
4. Click on the View Overview to return to the overview report. 

> More details on logging messages and events can be found on the [Microsoft Documentation page for SSIS](https://docs.microsoft.com/en-us/sql/integration-services/performance/integration-services-ssis-logging?view=sql-server-ver15).

## Demo 4 - Performance

1. On the Overview report, click on the *View Performance* link.
2. Right now this is not going to show much, as we've only executed once.
3. Go off camera to run the report several more times, then return here.
4. Click the *refresh* icon (the circle) in the toolbar. 
5. Show how the duration and start times vary.

## Demo 5 - Summary with multiple executions
1. Close the performance page.
2. Right Click on SSISDB
3. In the menu select *Reports*, then *Standard Reports*, *All Executions*.
4. Show how each execution is now listed in the canned report.

## Up Next

At this point, you can see how to deploy your project, execute a single package, and see the results in the built in canned reports. 

Typically though, you want to run multiple packages at the same time, and in the next module we will see how to implement that. 