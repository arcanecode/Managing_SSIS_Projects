# Module 4 - Deploying to the Catalog

## Demo 1 - Deploy the Project

1. Explain that in order for logging to work, the package must be executed from SSMS on the server. Logging does not work if the package executes in Visual Studio.
2. Right click on the Demo_SSIS project and pick *Deploy* in the menu.
3. In the Deploy overview, just hit __Next__.
4. Note that it skipped the Select Source step, as it knows we are deploying from our SSIS project.
5. For the deployment target, leave it set to _SSIS in SQL Server_ and click __Next__.
6. For the server name, just enter _localhost_.
7. Leave authentication set to Windows Authentication and click the __Connect__ button.
8. Click the __Browse__ button beside the Path.
9. Since our folder doesn't exist, we will need to click the __New folder__ button.
10. Enter __Demo_SSIS__ for the folder name, you can also enter a description.
11. Click __OK__.
12. Back in the _Browse for folder or Project_ window, ensure the new Demo_SSIS is selected and click __OK__.
13. Click __Next__ to continue.
14. Explain the Review Summary, then click the __Deploy__
15. Show the results of the deployment and click __Close__ to exit the results dialog.
16. "In the next section, let's see how to execute our packages"

## Demo 2 - Execute the project

1. Open SSMS
2. Expand the TargetDB_Dev database, then its tables.
3. Right click on Dimension.Employee, pick Select Top 1000 Rows to show the table is empty.
4. Navigate to and expand the _Integration Services Catalogs_ branch.
5. Expand the _SSISDB_ branch.
6. Point out, then expand the _Demo_SSIS_ branch.
7. Expand the _Projects_ branch.
8. Expand the _Demo_SSIS_ branch.
9. Expand the _Packages_ branch.
10. Right click on _Employee.dtsx_. In the menu, click __Execute__. Note that it will run the package, using the same connection strings and variables that were setup in the package.
11. Re-run the Select Top 1000 rows query to show the employee table is now populated.

## Up Next

In the next module, Using Canned Dashboard Reports, you will see how to look at the results of your package execution.

[Return to the DemoSteps document](DemoSteps.md)
