/*-----------------------------------------------------------------------------------------------*/
-- App.PackageLogger
--
-- Author..: Robert C. Cain
-- Synopsis: Contains log for package executions
--
-- Description
--   This table will log execution of packages, including package name, row counts, execution
--   time, and more. Each package should have an Insert task to add to this table as the last
--   step in their control flow.
--
/*-----------------------------------------------------------------------------------------------*/
create table [App].[PackageLogger]
(
    [PackageLoggerId]    int identity not null primary key
  , [PackageName]        varchar(256) not null
  , [DataFlowName]       varchar(256)
  , [SubFlowInformation] varchar(256)
  , [RowsInserted]       bigint
  , [RowsUpdated]        bigint
  , [RowsDeleted]        bigint
  , [RowsUnaffected]     bigint
  , [ExecutionBegan]     datetime default getdate()
  , [ExecutionEnded]     datetime default getdate()
  , [ExecutionStatus]    varchar(256)
)
