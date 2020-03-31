/*-----------------------------------------------------------------------------------------------*/
-- [App].[LogMessage]
--
-- Author..: Robert C. Cain
-- Synopsis: Updates the application logger
--
-- Description
--   Lists the debug log in reverse order so the most recent rows are first
--
-- Parameters
--   None
--
-- Example 1
--   exec App.ShowDebugLog
--
/*-----------------------------------------------------------------------------------------------*/
create procedure [App].[ShowDebugLog]
as
begin
  select [LogKey] 
       , [Message] 
       , [LogTime] 
    from App.DebugLog
   order by [LogTime] DESC;
end