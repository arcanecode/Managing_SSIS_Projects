/*-----------------------------------------------------------------------------------------------*/
-- [App].[ElapsedTimeText]
--
-- Author..: Robert C. Cain
-- Synopsis: Calculates the elapsed time between two dates
-- Returns.: A string with the elapsed time in "1 Year 1 Month 1 Days 1 Hours 1 Minutes 1 Seconds" format
--
-- Description
--   Calculates the elapsed time between two dates, and returns it as a string in the format of
--   1 Year 1 Month 1 Days 1 Hours 1 Minutes 1 Seconds. Beginning at the start, if a value is 0 it is omitted
--   from the return, however seconds will always be returned.
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
--   Returns the value '1 Day 2 Hours 3 Minutes 6 Seconds'
--
-- Example 2
--   select App.ElapsedTimeText('2019-07-17 01:02:03', '2019-07-17 03:05:09')
--
--   Returns the value '2 Hours 3 Minutes 6 Seconds'
--
-- Example 3
--   select App.ElapsedTimeText('2019-07-17 01:02:03', '2019-07-17 01:05:09')
--
--   Returns the value '3 Minutes 6 Seconds'
--
-- Example 4
--   select App.ElapsedTimeText('2019-07-17 01:02:03', '2019-07-17 01:02:09')
--
--   Returns the value '6 Seconds'
--
-- Example 5
--   select App.ElapsedTimeText('2019-07-17 01:02:03', '2019-07-17 01:02:03')
--
--   Returns the value '0 Seconds'
--
--
--  See Also
--    App.ElapesedTimeNumeric 
--
/*-----------------------------------------------------------------------------------------------*/
create function [App].[ElapsedTimeText]
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

  set @returnText = CASE WHEN @yy > 0 THEN CAST( @yy AS varchar(10)) + ' Year '    ELSE '' END
                  + CASE WHEN @mm > 0 THEN CAST( @mm AS varchar(10)) + ' Months '  ELSE '' END
                  + CASE WHEN @dd > 0 THEN CAST( @dd AS varchar(10)) + ' Days '    ELSE '' END
                  + CASE WHEN @hh > 0 THEN CAST( @hh AS varchar(10)) + ' Hours '   ELSE '' END
                  + CASE WHEN @mi > 0 THEN CAST( @mi AS varchar(10)) + ' Minutes ' ELSE '' END
                  + CASE WHEN @ss > 0 THEN CAST( @ss AS varchar(10)) + ' Seconds'  ELSE '' END 
      
  if @returnText = '' set @returnText = '0 seconds'

  -- Return our output
  return @returnText

end
