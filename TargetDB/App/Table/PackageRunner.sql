/*-----------------------------------------------------------------------------------------------*/
-- App.PackageRunner
--
-- Author..: Robert C. Cain
-- Synopsis: The package runner table is used to control execution in the master pacakge.
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
--   In the master package, it only reads values where the RunPackage column is set to Y. So
--   to keep a package from being executed, simply set the RunPackage column to some other value.
--   N would be preferred and is suggested for clarity.
--
--  See Also
--    [App].[PackageRunnerInitialLoad] stored procedure
--    Master.dtsx package in the AldenOneIS project
--
/*-----------------------------------------------------------------------------------------------*/
create table [App].[PackageRunner]
(
    [PackageRunnerID]    int identity   not null primary key
  , [LoadPath]           int not null
  , [LoadOrder]          int not null
  , [PackageName]        varchar(256)   not null
  , [PackageDescription] varchar(256)
  , [Parameter]          varchar(256)
  , [Notes]              varchar(1024)
  , [RunPackage]         char(1)        default 'Y'
)
