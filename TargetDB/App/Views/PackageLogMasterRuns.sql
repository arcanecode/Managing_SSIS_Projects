/*-----------------------------------------------------------------------------------------------*/
-- App.PackageLogMasterRuns
--
-- Author..: Robert C. Cain
-- Synopsis: Returns a list of run times for the master package.
--
-- Description
--   This view looks at the PackageLogger and only returns the last row of a master pacakge
--   execution. The specific rows we want will have "Run Ended" as part of the package name.
--
--   This provides an easy way to review the execution of master packages to make sure they
--   ran, and how long they ran for.
--
--  See Also
--    [App].[PackageLogger] table
--    Master.dtsx package in the AldenOneIS project
--
/*-----------------------------------------------------------------------------------------------*/
create view [App].[PackageLogMasterRuns] as
select [PackageLoggerId]
     , [PackageName]
     , [DataFlowName]
     , case when [SubFlowInformation] is null then '' else [SubFlowInformation]  end as [SubFlowInformation] 
     , case when [RowsInserted] is null then '' else format([RowsInserted], '#,0') end as [RowsInsertedF]
     , case when [RowsUpdated] is null then '' else format([RowsUpdated], '#,0') end as [RowsUpdatedF]
     , case when [RowsDeleted] is null then '' else format([RowsDeleted], '#,0') end as [RowsDeletedF]
     , case when [RowsUnaffected] is null then '' else format([RowsUnaffected], '#,0') end as [RowsUnaffectedF]
     , [App].[ElapsedTimeText]([ExecutionBegan], [ExecutionEnded])    as ExecutionTimeText
     , [App].[ElapsedTimeCompact]([ExecutionBegan], [ExecutionEnded]) as ExecutionTime
     , case when [RuntimeEnvironment] is null then '' else [RuntimeEnvironment] end        as [RuntimeEnvironment]
     , [RowsInserted]
     , [RowsUpdated]
     , [RowsDeleted]
     , [RowsUnaffected]
     , [ExecutionBegan]
     , [ExecutionEnded]
     , [ExecutionStatus] 
 from [App].[PackageLogger]
 where PackageName like '%Run Ended%'
