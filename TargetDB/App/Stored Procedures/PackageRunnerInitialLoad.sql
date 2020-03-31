/*-----------------------------------------------------------------------------------------------*/
-- App.PackageRunnerInitialLoad
--
-- Author..: Robert C. Cain
-- Synopsis: Loads the PackageRunner table
--
-- Description
--   The PackageRunner table is used by the MasterPackage to determine the order in which
--   it executes packages.
--
--   The master package has four paths, the path to use is indicated by the LoadPath column.
--
--   The LoadOrder indicates the order a package is run within a path. The numbers do not
--   have to be sequential. 
--
--   The package name is the name of the package, including the dtsx extension.
--
--   For the parameter you can place any parameters to pass into the package. If there are
--   none, use an *.
--
--   The note column is optional, and is used for documenting things like precedence requirements.
--
-- Notes
--  For simplicty, we wipe what is in the table and reset with each deploy. Thus it's critical
--  this script be kept up to date with the correct order for loading. 
--
-- Examples
--  exec [App].[PackageRunnerInitialLoad]
--
--  See Also
--    App.PackageRunner Table. 
--    Master.dtsx package in the AldenOneIS project
--
/*-----------------------------------------------------------------------------------------------*/
create procedure [App].[PackageRunnerLoad]
as
begin
  
  truncate table [App].[PackageRunner];

  insert into [App].[PackageRunner]      
         ( [LoadPath], [LoadOrder], [PackageName], [PackageDescription], [Parameter], [Notes] )  
  values
       -- Path 1
         ( 1, 1, 'Employee.dtsx', 'Get Employee Data', '*' , null)


       -- Path 2
       , ( 2, 1, 'City.dtsx', 'Get Resource data from JRM source', '*', null )

       -- Path 3

       -- Path 4

       -- Path 5

       -- Path 6



  return 0

end
