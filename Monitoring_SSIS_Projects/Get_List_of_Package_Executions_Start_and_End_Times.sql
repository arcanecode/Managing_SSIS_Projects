/*---------------------------------------------------------------------------*/
/* Get a listing of package executions, start / end time, and status.        */
/*                                                                           */
/* Author: Robert C. Cain | @ArcaneCode | arcanecode@gmail.com               */
/*         http://arcanecode.com                                             */
/*                                                                           */
/* This script is Copyright (c) 2018, 2019, 2020 Robert C. Cain.             */
/* All rights reserved.                                                      */
/*                                                                           */
/* The code herein is for demonstration purposes. No warranty or guarentee   */
/* is implied or expressly granted.                                          */
/*                                                                           */
/* This script may not be reproduced in whole or in part without the         */
/* express written consent of the author. Portions may be be used within     */
/* your own projects.                                                        */
/*---------------------------------------------------------------------------*/

USE SSISDB
GO

DECLARE @pFromDate AS DATETIME;
DECLARE @pThruDate AS DATETIME;
DECLARE @Status AS INT = 7;

-- Default to all runs since midnight
SET @pFromDate = DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0);
SET @pThruDate = DATEADD(day, 1, @pFromDate);

Declare @Statuses TABLE(StatusNum INT)
IF @Status IN (7,2,3) INSERT @Statuses VALUES(@Status)
ELSE INSERT @Statuses VALUES (1),(4),(5),(6),(8),(9)

SELECT [execution_ID]  ExecutionID,
	CASE [Status]
       WHEN 1 THEN 'Created' 
       WHEN 2 THEN 'Running' 
       WHEN 3 THEN 'Canceled' 
       WHEN 4 THEN 'Failed' 
       WHEN 5 THEN 'Pending' 
       WHEN 6 THEN 'Ended unexpectedly' 
       WHEN 7 THEN 'Success' 
       WHEN 8 THEN 'Stopping' 
       WHEN 9 THEN 'Completed'
       ELSE 'Others' 
	 END [StatusText]
        , [folder_name]  FolderName
        , [project_name]  ProjectName
        , [package_name] PackageName
        , [start_time] StartTime
        , [end_time] EndTime
        ,(DATEDIFF(s,[start_time],[end_time]) / 60.0) AS ElapsedTimeInMinutes
	FROM [catalog].[executions]
 WHERE ([start_time] IS NULL OR CONVERT (datetime, [start_time]) >= @pFromDate) 
   AND	([start_time] IS NULL OR CONVERT (datetime, [start_time]) <= DATEADD(day,1,@pThruDate)) 
   AND [Status] in (SELECT [StatusNum] FROM @statuses)
 ORDER BY execution_id desc
