/*-----------------------------------------------------------------------------------------------*/
-- [App].[LogMessage]
--
-- Author..: Robert C. Cain
-- Synopsis: Updates the application logger
--
-- Description
--   Inserts the passed in message into the App.DebugLog table
--
-- Parameters
--   Message - The text to write to the debug log.
--
-- Example 1
--   exec App.LogMessage ('Some Data Here')
--
/*-----------------------------------------------------------------------------------------------*/
create procedure [App].[LogMessage]
  @Message varchar(2000)
as
begin

  insert into App.DebugLog
    ([Message])
  values
    (@Message)
  
END