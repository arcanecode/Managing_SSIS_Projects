# Module 9 - Using the Catalog for Logging

In the slides, you will have learned that SSIS has several built in levels for logging. In here we'll look at examples of four, and how the report changes depending on the level.

The will then see how to query the logs directly. 

## Demo 1 - Basic Logging

1. Go to the Master package, right click and pick Execute.
2. Select the Test environment at the bottom.
3. Click the _Advanced_ tab.
4. Call attention to the Logging Level, and hit the drop down.
5. Explain we'll be looking at several of these, for now leave on Basic and click OK to run the package. 
6. When prompted, open the Overview Report.
7. When it finishes running, click View Messages. The messages are the logged information.
8. Scroll down to show the messages. 
9. In the messages, point out why having good names for each task is important, in the log it displays the task name.
10. Pre/Post validate messages indicate it is inspecting the tasks to ensure properties are set correctly. Not missing DB connections, etc.
11. Pre/Post execute messages indicate a task is about to start, or has completed. 
12. The columns returned are as follows:

| Column | Value |
| --- | --- |
| Message Type | Type SSIS Message type, i.e. Pre/Post Execute |
| Message Time | The time the message is logged. SSIS uses this for calculating task durations |
| Message | The full message text |
| Message Source Name | The task that generated the message |
| Subcomponent Name | The subtask, most often used with data flow tasks to indicate the component inside the data flow |
| Execution Path | The full path to the task, Package Name \ Task \ ... sub tasks (if any) |

When there are errors, the information here can help pinpoint what task a package failed on.

## Demo 2 - Performance Logging

1. Rerun the package, this time going to the Advanced tab and picking a logging level of _Performance_.
2. Once the package completes, go to the View Messages.
3. Show that under Performance, it does minimal logging and identifies only items that may have a performance impact.

## Demo 3 - Verbose Logging

1. Rerun the package, this time going to the Advanced tab and picking a logging level of _Verbose_.
2. Once the package completes, go to the View Messages.
3. Show that under Verbose, it does an extreme amount of logging.
4. At the bottom, show that while Basic logging produced a 2 page report, Verbose created 115 pages of logs.
5. Sometimes when you have an error and are having problems tracking it down, verbose may be the only way to find it.
6. Explain that Verbose logging will adversely impact package run time, causing a package to take longer to run due to all the logging it is doing.

Mention there are two other logging levels. None will not log anything, which makes the package run the fastest it can, but if an error occurs it will be very difficult to diagnose.

The other option is for custom SSIS logging, however this can be a bit complex to setup. Instead, in this course in a later module we will show how to setup your own custom logging directly in the packages.

## Demo 4 - Querying the logs

1. Start the demo with SSISDB database expanded to the views.
2. Close any open tabs.
3. Open the Monitor_SSIS_Projects SSMS solution in SSMS.
4. Show the large number of views setup for your use. To make them easier to learn, several queries have been included in the project. Copy these into SSMS (or create your own SSMS solution) to use them.

### Demo 4.1 - List All Pacackags In The Catalog

1. Start with the simplest query.
2. In this, it simply queries the Packages view, joining to the projects and folders views to extract the names, and lists all the packages currently in the catalog.
3. For large SSIS installations, you can add WHERE clauses to filter for folders and projects.

### Demo 4.2 - Get List of Package Executions Start and End Times

1. This query gets the start and end times for each package exectued by you in SSIS. It also includes the status (Success, Fail, etc)
2. Note that in this example it only includes the Master package. This is because Master is the only one we explictly executed. It in turned executed the others, and while they were logged the actual execution of each was not. 
3. This is the one drawback to the Master package, however we can solve this with our own custom logging which we will demonstrate in a later module.

### Demo 4.3 - Get Number of Package Executions and Average Runtime

1. This query will get the number of explicit package executions, i.e. the master package, and the average run time.
2. By monitoring this over time, you can look for a spike or a gradual increase in run times over time.

### Demo 4.4 - Get Top 5 Longest Running Packages

1. In this, we will query the executables view (as opposed to the executions in the previous query) so we can get into specific packages.
2. Also note we are filtering out the Master package. This is because the master will always take the longest.

### Demo 4.5 - Get List of Executed Tasks

1. Here we can dive down to the indivudal task level. 
2. We can also use WHERE clauses to filter for a specific package.

### Demo 4.6 - Get Last 5 Packages Executed

1. This query returns the last five packages executed, along with their run time.
2. In our demo, this should always return Master, you may wish to filter it out.

### Demo 4.7 - Get Messages Generated During Package Execution

1. This query returns messages from the SSIS Message Log. Note we have filtered it for only OnPostExecute, which is normally the most useful message.
2. You could also leave it off to get all messages, or have it seek for only error / failed messages to look for issues.

### Demo 4.8 - Executive Dashboard

1. This query will produce an "executive summary", a simple count of packages by their execution status. This report will let you quickly identify when you have failures occuring, as well as how many packages are currently running.
2. Note the variables, first is the data range, by default only runs since midnight, basically today's runs, are included. You may wish to expand this depending on your package execution schedule.
3. Also note the FolderNameContains and ProjectNameContains. This will filter for only a specific project, in this case our demo. You could update the query to remove these filters, or have it return additional rows of counts by project/folder name.

### Up Next

In the first part of this module we saw how the logging levels affected what was written to the SSIS logs. 

In the latter half we saw how to query those logs directly using some queries. You can customize these queries for your own use, or use them as a basis for some SSRS reports.

In the next module, we'll look to see how to author your own custom logging inside the packages.