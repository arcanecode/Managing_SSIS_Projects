# Module 7 - Configuring a Project or Package

## Demo 1 - Multiple DBs

1. In SSMS, show how we have three copies of the TargetDB, Dev, Test and Prod. For the demo they are all on the same server, but they could just as easily be on three different servers as they hopefully would be in real life.
2. Expand the TargetDB_Prod, and do a select top 1000 on the Employee table to show no rows.

## Demo 2 - Configure the package/project.

1. Under the Integration Services Catalogs, expand the following tree:
2. Demo_SSIS > Projects > Demo_SSIS > Packages > Master.dtsx
3. Right click on Master.dtsx and pick _Configure_ in the menu.
4. Show that it has no parameters or connection managers.
5. Explain this is because they use the ones from the _Project_ level. If we had defined any that were package specific they would be here, but in our demo everything comes in at the project level.
6. Click Cancel to close this dialog.
7. Now right click on the second Demo_SSIS in the tree, and pick Configure.
8. Resize the Configure dialog box to give more room to the insides.
9. On the _Parameters_ tab, click the `...` beside the RuntimeEnvironment variable value.
10. Pick the _Edit value_ option.
11. For the value enter **Prod**. 
12. Click OK to close the set parameter value dialog box.
13. Click the Connection Managers tab.
14. Click on the second line for the TargetDB_Dev.
15. Click on the Connection String ... to the right.
16. Copy the Default Value from the package into the clipboard.
17. Click on Edit Value
18. Paste in the clipboard version then edit it, replace the Dev with Prod in the target db name.
19. Click OK to close the parameter value dialog.
20. Click on the Initial Catalog, and change it's value to Prod as well.
21. Now click on the first package part in EmployeePP.dtsx. Repeat the above steps to change it to the production database.
22. Do the same for the second package part.
23. Click OK to close the package configuration.

## Demo 3 - Run the Master package

1. Return to the list of packages
2. Right click on Master.dtsx, and pick _Execute_.
3. Point out that the RuntimeEnvironment parameter is set to Prod, which is what we configured.
4. Click on the Connection Managers tab.
5. Point out how its values have been updated to the Prod database.
6. Click OK to run the package
7. Click Yes to show the runtime overview report
8. If the status is 'Running', use the refresh button until it shows Succeeded.

## Demo 4 - Show the results

1. In the overview report, in the Parameters Used area on the right, point out the connection string and the RuntimeEnvironment variable
2. Return to the query we ran earlier on the Employee table in the Prod database and run again.
3. Show it is now populated.

## Up Next

These settings will remain, even between deployments. Which is great, but what if you want to change settings between executions so you can run to Dev, Test, and Prod?

That is where environments come into play, and is the topic of our next module.
