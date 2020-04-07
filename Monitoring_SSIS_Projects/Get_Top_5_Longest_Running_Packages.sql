/*---------------------------------------------------------------------------*/
/* This will produce the top 5 longest running packages                      */
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
USE [SSISDB]
GO

DECLARE @pFromDate AS DATETIME
DECLARE @pThruDate AS DATETIME

SET @pFromDate = DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0);
SET @pThruDate = DATEADD(day, 1, @pFromDate);

SELECT ExecutionID
     , FolderName
     , ProjectName
     , PackageName
     , StartTime
     , EndTime
     , ElapsedTimeInMinutes
     , ElapsedTimeInSecond
     , TasksExecuted
     , TotalTasksToExecute
    -- , ((CAST(TasksExecuted AS DECIMAL(5,2)) / TotalTasksToExecute) * 100) AS PercentComplete
  FROM (SELECT TOP 5
               ce.[execution_id]  AS ExecutionID
             , ce.[folder_name]   AS FolderName
             , ce.[project_name]  AS ProjectName
             , ce.[package_name]  AS PackageName
             , ce.[start_time]    AS StartTime
             , ce.[end_time]      AS EndTime
    	       , (DATEDIFF(s,  ce.[start_time],ce.[end_time]) / 60.0) AS ElapsedTimeInMinutes
    	       , DATEDIFF(s,  ce.[start_time],ce.[end_time]) AS ElapsedTimeInSecond
    	       , (SELECT COUNT(*) 
    			        FROM (SELECT Distinct 
                               cec.[executable_id]
    			  	               , cec.[execution_id]
    			  	               , cec.[executable_name]
    			  	               , cec.[executable_guid]
    			  	               , cec.[package_name]
    			  	               , cec.[package_path]
    			                FROM [catalog].[executables] as cec
    			               WHERE cec.execution_id = ce.execution_id
    			                 AND cec.package_name = ce.package_name
    			             ) AS te
    	         ) AS TasksExecuted
    	       , (SELECT COUNT(*) 
    		          FROM (SELECT Distinct 
                               cet.[executable_id]
    				                 , cet.[executable_name]
    				                 , cet.[executable_guid]
    				                 , cet.[package_name]
    				                 , cet.[package_path]
    			                FROM [catalog].[executables] AS cet
    			               WHERE cet.execution_id = ce.execution_id
    			                 AND cet.package_name = ce.package_name
    		               ) AS ttte
    	         ) AS TotalTasksToExecute
          FROM [catalog].[executions] AS ce
         WHERE start_time 
               BETWEEN CAST(CAST(CAST(@pFromDate AS DATE) AS VARCHAR) + ' 00:00:00' AS DATETIME) 
                   AND CAST(CAST(CAST(@pThruDate AS DATE) AS VARCHAR) + ' 23:59:59' AS DATETIME)
           AND ce.[package_name] NOT LIKE 'Master%'  -- If you have master packages you may want to filter them out
         ORDER BY DATEDIFF(s,  ce.[start_time],ce.[end_time]) DESC
       ) AS TopX
