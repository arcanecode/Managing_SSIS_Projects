# Module 8 - Managing Variables and Connection Strings through Environments

## Demo 1 - Create an Environment

1. Expand the Demo_SSIS folder under Integration Services Catalogs.
2. Right click on Environments
3. Select _Create Environment_ in the menu.
4. In the dialog give it the name __Prod__.
5. Provide a description, such as __Production Configuration__.
6. Click __OK__ to create the environment.

## Demo 2 - Add variables to the Environment

1. Right click on the newly created environment.
2. Select _Properties_ on the menu.
3. Click on the page for _Variables_.
4. For the first variable, use the settings below:

| Name | Type | Description | Value |
| --- | --- | --- | --- |
|RuntimeEnv |String |Runtime Environment Name |Prod |

5. Leave the Senstive box unchecked for this and all other variables added in this module.
6. Next, add two more variables with the following properties.

| Name | Type | Description | Value |
| --- | --- | --- | --- |
|TargetConnectonStr | String | Target DB Connection String |Data Source=localhost;Initial Catalog=TargetDB_Prod;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;|
|TargetInitCatalog |String |Initial Target Catalog (database) |TargetDB_Prod |

## Demo 3 - Configure the Project to use Environment Variables

1. Remind students this refers to SSIS environment variables, not the environment variables that may reside on the computer.
2. Right click on the project _Demo_SSIS_ and pick _Configure_.
3. In the dialog, click on the _References_ page.
4. Click the _Add_ button.
5. In the dialog that appears, select the _Prod_ environment and click _OK_.
6. Click on the _Parameters_ page.
7. Click the `...` besdie the RuntimeEnvironment variable.
8. In the dialog, take the _Use environment variable_ option.
9. Use the drop down list to pick __RuntimeEnv__.
10. Mention that while you can name the variable the same name as the property, and it's often easier to do so, here we used different names just to illustrate it is possible.
11. Click OK to close the Set Parameter Value dialog.
12. Click the _Connection Managers_ tab.
13. Select the first connection string for the TargetDB.
14. Repeating the above steps, click the `...` beside ConnectionString, change to use an environment variable, pick ConnectionStr, and click OK to close.
15. Repeat for the InitialCatalog, using InitCatalog for the variable.
16. Repeat these steps for the connection managers attached to the EmployeePP parts.
17. When done, click OK.

## Demo 4 - Execute using the environment

1. In SSMS, drill down under SSIS to the Master package.
2. Right click on it and pick Execute.
3. In the Execute Package window, place a check mark at the bottom beside __Environment__.
4. In the drop down, pick the __Prod__ environment then click __OK__ to run the package.
5. When asked, open the overview report.
6. In the lower right under Parameters Used, point out the connection string and runtime environment parameter.
7. Explain that off screen I am going to repeat the above steps to create environments for Dev and Test, alterning the values appropriately. Stress it is important I use the same variable names for all three environments.

## Offscreen: Create the environments

Offscreen, create the new environments with the following values.

|New Environment Name| Name | Type | Description | Value |
| --- | --- | --- | --- | --- |
| Test |RuntimeEnv |String |Runtime Environment Name |Test |
| Test |TargetConnectonStr | String | Connection String |Data Source=localhost;Initial Catalog=TargetDB_Test;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;|
| Test |TargetInitCatalog |String |Initial Catalog (database) |TargetDB_Test |
| Dev |RuntimeEnv |String |Runtime Environment Name |Dev |
| Dev |TargetConnectonStr | String | Connection String |Data Source=localhost;Initial Catalog=TargetDB_Dev;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;|
| Dev |TargetInitCatalog |String |Initial Catalog (database) |TargetDB_Dev |

## Demo 5 - Execute using an alternate environment

1. Show the Environments tree in SSMS under the DEMO_SSIS folder with the new environments.
2. Right click on Test, and pick its Properties.
3. Click on the Variables page.
4. Show the three variables, and their values.
5. Note that it was not necessary to Configure the project again, those variables are already set.
6. Close the environment dialog, go to the Master package, right click and pick Execute.
7. At the bottom, put a check beside Environment.
8. In the drop down show our three environments. Pick one (perhaps Test) and click OK to execute the package.
9. When prompted, open the Overview Report.
10. Point out the environment variables in the Parameters Used area of the report.

## Up Next

In this module we saw how to configure SSIS to run packages with multiple environments.

[Return to the DemoSteps document](DemoSteps.md)
