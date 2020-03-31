/*-----------------------------------------------------------------------------------------------*/
-- App.DebugLog
--
-- Author..: Robert C. Cain
-- Synopsis: Table for logging messages
--
-- Description
--   It can be useful to log messages during execution of various tasks, such as stored 
--   procedures, SSIS packages, and the like. This simple table provides a place to store 
--   messages to assist in debugging. 
--
-- See Also
--   The stored procedure App.LogMessage can be used to easily insert a row into the debug
--   log table.
--
/*-----------------------------------------------------------------------------------------------*/
create table [App].[DebugLog]
( 
    [LogKey] int identity NOT NULL
  , [Message] varchar(2000)
  , [LogTime] DateTime2 default getdate() NOT NULL
)
