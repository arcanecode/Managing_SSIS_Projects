# Module 12 - Creating Reusable Units of an SSIS Package Workflow

## Demo 1 - InsertExecutionBegan Package Part

1. In the solution explorer, show how you could right click on Control Flow under Package Parts and pick New _Control Flow Package Part_.
2. For our demo, we will open the InsertExecutionBegan.dtsxp part
3. Show the variables at the bottom. The five variables are used to pass data into the part: IEB_DataFlowName, IEB_PackageName, IEB_RuntimeEnvironment, IEB_SubflowInformation, and IEB_ExectionBegan.
4. Also point out that all variables are scoped to the control flow task, not to a bigger package or even project.
5. Next, show the Connection Manager for the part. Explain that the part cannot share the connection manager for the project, but must use one of it's own.
6. As mentioned in the introduction to this module, a Package Part can have one, and only one task. In this case we placed an Execute SQL task on our design surface.
7. Open the SQL Task, then open the SQL query in it.
8. As you can see, the logic is identical to the one we used in our custom logging you saw in a previous module. We insert a row into the package logger table.
9. Cancel the query, then go to the Paramter Mapping page.
10. Like before, the values that go into the query come from our variables.
11. Now lets go see how to use the package part in a package.

## Demo 2 - EmployeePP.dtsx

1. Begin by opening the EmployeePP.dtsx package.
2. In the SSIS Toolbox, show the Package Parts at the bottom.
3. To use one, explain you just drag and drop it into the designer like any other tool.
4. Show how we've used it in the packages control flow.
5. Note how a control that is a package part has a little P in the upper right corner.
6. Click on it to show the variables for the part.
7. Note how each variable in the package part is mapped to a package variable through an expression.
8. Open one of the variables expression properties, and show how it is mapped by dragging and dropping the variable name to the expression.
9. As a final task in this package we have another package part, but this appears to have two controls in it, contrary to what was stated earlier about a part only having one control. Let's take a look at how we accomplished this.

## Demo 3 - InsertExecutionEnded Package Part

1. Open the InsertExecutionEnded Package Part from the solution explorer.
2. Explain that in this design we still only have one task on the designer, however that is a sequence task.
3. In the sequence task we can put multiple items.
4. Here we have an expression task to get the current time and place it into a variable, IEE_ExecutionEnded.
5. The second task is the task to update the package logger table. As you've seen both of these before in the module on custom logging, we won't go back into them now.
6. Show the variable list.
7. Point out that the values for all of these will need to come from the package where the control is used.
8. Return to the EmployeePP package.

## Demo 4 - Back to EmployeePP

1. Start with the package open, as well as the variables.
2. Point out the little P for package part.
3. Note you have the ability to expand and contract the sequence task.
4. You cannot, however, click on the components inside the package part.
5. Show the variables, and point out how they have been mapped to local variables except for the IEE_ExecutionEnded. That variable is only used inside the package part.
6. After a package with package parts is deployed, you must specially address the connection strings for the part, let's go take a look.

## Demo 5 - Connection Strings for Package Parts

1. Begin the demo in SSIS. Right click on Demo_SSIS and pick Configure.
2. Go to the Connection Manager tab. Expand just a bit to show the container and name.
3. Show that I have two containers for the EmployeePP package. These represent the connection strings used in each package part.
4. If I had used these parts in multiple packages, each package would be listed and need to be addressed.

## Up Next

We're almost to the finish line! In the next, our final module, we'll review what we've learned.

[Return to the DemoSteps document](DemoSteps.md)
