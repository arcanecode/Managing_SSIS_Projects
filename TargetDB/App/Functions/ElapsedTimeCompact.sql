/*-----------------------------------------------------------------------------------------------*/
-- [App].[ElapsedTimeCompact]
--
-- Author..: Robert C. Cain
-- Synopsis: Calculates the elapsed time between two dates
-- Returns.: A string with the elapsed time in D.HH:MM:SS format
--
-- Description
--   Calculates the elapsed time between two dates, and returns it as a string in the format of
--   D HH:MM:SS where D=Days, HH=Hours, MM=Minutes, and SS=Seconds
--
-- Parameters
--   FromDate - Starting Date
--   ThruDate - Ending date
--
-- Notes
--  If the FromDate is greater than the ThruDate, the dates are swapped then the calculation is
--  performed. 
--
--  Despite the word numeric in the name, it actually returns a varchar string, just with the
--  timespan formatted in the aforementioned D HH:MM:SS format.
--
-- Examples
--   select App.ElapsedTimeCompact('2019-07-16 01:02:03', '2019-07-17 03:05:09')
--
--   -- Returns the value '1 02:03:06'
--
--  See Also
--    App.ElapesedTimeText 
--
/*-----------------------------------------------------------------------------------------------*/
create function [App].[ElapsedTimeCompact]
(
    @FromDate datetime
  , @ThruDate datetime
)
returns varchar(128)
as
begin

  declare @swapdate datetime
  declare @returnCompact varchar(128)
  
  -- If the from date is greater than the thru date then swap them. 
  if (@FromDate > @ThruDate)
  begin
    set @swapdate = @FromDate
    set @FromDate = @ThruDate
    set @ThruDate = @swapdate
  end
  
  declare @diffDays int = datediff(day, @FromDate, @ThruDate)

  declare @diff datetime = @ThruDate - @FromDate
  declare @hh int = DATEPART(HOUR, @diff) 
  declare @mi int = DATEPART(MINUTE,  @diff) 
  declare @ss int = DATEPART(SECOND,  @diff)

  set @returnCompact = format( @diffDays, '#,0') + ' ' 
                     + format( @hh, '00') + ':'
                     + format( @mi, '00') + ':'
                     + format( @ss, '00') 
  
  -- Return our output
  return @returnCompact

end
