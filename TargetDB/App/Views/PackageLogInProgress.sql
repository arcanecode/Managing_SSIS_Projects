/*-----------------------------------------------------------------------------------------------*/
-- App.PackageLogInProgress
--
-- Author..: Robert C. Cain
-- Synopsis: Returns a detailed list of run times for all packages that are currently executing.
--
-- Description
--   This view looks at the PackageLogger table and only returns execution records for the
--   packages which are currently running.
--
--  See Also
--    App.PackageLogger table
--    Master.dtsx package in the AldenOneIS project
--
/*-----------------------------------------------------------------------------------------------*/
create view [App].[PackageLogInProgress] as 
select [PackageLoggerId]
     , [PackageName]
     , [DataFlowName]
     , case when [SubFlowInformation] is null then '' else [SubFlowInformation]  end as [SubFlowInformation] 
     , case when [RowsInserted] is null then '' else format([RowsInserted], '#,0') end as [RowsInsertedF]
     , case when [RowsUpdated] is null then '' else format([RowsUpdated], '#,0') end as [RowsUpdatedF]
     , case when [RowsDeleted] is null then '' else format([RowsDeleted], '#,0') end as [RowsDeletedF]
     , case when [RowsUnaffected] is null then '' else format([RowsUnaffected], '#,0') end as [RowsUnaffectedF]
     , [App].[ElapsedTimeText]([ExecutionBegan], [ExecutionEnded])    as ExecutionTimeText
     , case when [ExecutionStatus] is null then '' else [ExecutionStatus] end as [ExecutionStatus]
     , [RowsInserted]
     , [RowsUpdated]
     , [RowsDeleted]
     , [RowsUnaffected]
     , [ExecutionBegan]
     , [ExecutionEnded]
     , [App].[ElapsedTimeCompact]([ExecutionBegan], [ExecutionEnded]) as ExecutionTime
  from [App].[PackageLogger]
 where [ExecutionStatus] like 'In Progress%'

