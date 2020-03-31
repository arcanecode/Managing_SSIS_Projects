/*-----------------------------------------------------------------------------------------------*/
-- [App].[ElapsedTimeTextCompact]
--
-- Author..: Robert C. Cain
-- Synopsis: Calculates the elapsed time between two dates
-- Returns.: A string with the elapsed time in "1y 1mo 1d 1h 1m 1s" format
--
-- Description
--   Calculates the elapsed time between two dates, and returns it as a string in the format of
--   1y 1mo 1d 1h 1m 1s. Beginning at the start, if a value is 0 it is omitted
--   from the return, however seconds will always be returned.
--
--   This routine is almost idential to ElapsedTimeText, except instead of the words year, 
--   month, day etc being spelled out they are replaced with a single character indicating
--   the time unit.
--
-- Parameters
--   FromDate - Starting Date
--   ThruDate - Ending date
--
-- Notes
--  If the FromDate is greater than the ThruDate, the dates are swapped then the calculation is
--  performed. 
--
-- Example 1
--   select App.ElapsedTimeText('2019-07-16 01:02:03', '2019-07-17 03:05:09')
--
--   Returns the value '1d 2h 3m 6s'
--
-- Example 2
--   select App.ElapsedTimeText('2019-07-17 01:02:03', '2019-07-17 03:05:09')
--
--   Returns the value '2h 3m 6s'
--
-- Example 3
--   select App.ElapsedTimeText('2019-07-17 01:02:03', '2019-07-17 01:05:09')
--
--   Returns the value '3m 6s'
--
-- Example 4
--   select App.ElapsedTimeText('2019-07-17 01:02:03', '2019-07-17 01:02:09')
--
--   Returns the value '6s'
--
-- Example 5
--   select App.ElapsedTimeText('2019-07-17 01:02:03', '2019-07-17 01:02:03')
--
--   Returns the value '0s'
--
--
--  See Also
--    App.ElapesedTimeText
--
/*-----------------------------------------------------------------------------------------------*/
create function [App].[ElapsedTimeTextCompact]
(
    @FromDate datetime
  , @ThruDate datetime
)
returns varchar(128)
as
begin

  declare @swapdate datetime
  declare @returnText varchar(128)
  
  -- If the from date is greater than the thru date then swap them. 
  if (@FromDate > @ThruDate)
  begin
    set @swapdate = @FromDate
    set @FromDate = @ThruDate
    set @ThruDate = @swapdate
  end
  
  declare @diff datetime = @ThruDate - @FromDate
  declare @yy int = DATEPART(YEAR,  @diff) - 1900
  declare @mm int = DATEPART(MONTH,  @diff) - 1
  declare @dd int = DATEPART(DAY, @diff) - 1 
  declare @hh int = DATEPART(HOUR, @diff) 
  declare @mi int = DATEPART(MINUTE,  @diff) 
  declare @ss int = DATEPART(SECOND,  @diff)

  set @returnText = CASE WHEN @yy > 0 THEN CAST( @yy AS varchar(10)) + 'y '    ELSE '' END
                  + CASE WHEN @mm > 0 THEN CAST( @mm AS varchar(10)) + 'mo '  ELSE '' END
                  + CASE WHEN @dd > 0 THEN CAST( @dd AS varchar(10)) + 'd '    ELSE '' END
                  + CASE WHEN @hh > 0 THEN CAST( @hh AS varchar(10)) + 'h '   ELSE '' END
                  + CASE WHEN @mi > 0 THEN CAST( @mi AS varchar(10)) + 'm ' ELSE '' END
                  + CASE WHEN @ss > 0 THEN CAST( @ss AS varchar(10)) + 's'  ELSE '' END 
      
  if @returnText = '' set @returnText = '0s'

  -- Return our output
  return @returnText

end
