# Module 11 - Creating an SSIS Package Template for Re-use

The following instructions apply to the Visual Studio 2019 Community Edition. For other versions the instructions may vary slightly.

## Adding the template to the Visual Studio 2019 Templates

1. In the file explorer navigate to this path. (For 2017, change the date to 2017)

C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\IDE\CommonExtensions\Microsoft\SSIS\ProjectItems\DataTransformationProject\DataTransformationItems

2. Copy the template.dtsx file into this folder.
3. The second step is to update the vsdir file to add the template.
4. Open notepad or another text editor in admin mode.
5. The template for adding an entry to the vsdir file is:

```
YourPackageName.dtsx| |The name you want to appear|100|The description of the package| |21| |#44
```

6. Open the DtsProjectItems.vsdir file in notepad. For this demo, add the following line to the bottom of the file and save it.

```
Template.dtsx| |Demo_SSIS Template Package|100|A package for creating other packages from| |21| |#44
```

Note that some of the bars `|` have spaces between them.

> You can check all the fields of the vsdir file in the [Microsoft SSIS Documentation](https://docs.microsoft.com/en-us/visualstudio/extensibility/internals/template-directory-description-dot-vsdir-files)

## Use the template to create a new package

1. Return to your project in Visual Studio.
2. Right click on the project name, here _Demo_SSIS_. Make sure it is not the SSIS Packages branch within the project.
3. Click on _Add_, then _New Item_.
4. In the dialog that appers, click on Template Package, then give it a name.
5. Make the necessary chanes to the variables.
6. Open the Dataflow, and following the annotations create the data flow for this particular package.

[Return to the DemoSteps document](DemoSteps.md)
