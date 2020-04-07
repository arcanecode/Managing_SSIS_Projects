/*---------------------------------------------------------------------------*/
/* This will produce the last 5 packages run                                 */
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

/* This version is the shorter version for just the top 5 report */
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
     , CASE WHEN TotalTasksToExecute = 0        -- Check for divide by 0 
            THEN 100
            ELSE ((CAST(TasksExecuted AS DECIMAL(5,2)) / TotalTasksToExecute) * 100) 
        END AS PercentComplete
     , CAST(TasksExecuted AS VARCHAR) 
         + ' of ' 
         + CAST(TotalTasksToExecute AS VARCHAR) AS CompletionStatus
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
                            -- AND cec.package_name not like 'Master%'
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
    			               WHERE cet.package_name = ce.package_name
                           --   AND cet.package_name not like 'Master%'
    		               ) AS ttte
    	         ) AS TotalTasksToExecute
          FROM [catalog].[executions] AS ce
         WHERE start_time <= DATEADD(d, 1,GETDATE()) 
           --  AND ce.[package_name] NOT LIKE 'Master%'  -- If you have master packages you may want to filter them out
         ORDER BY start_time DESC
       ) AS TopX

/* This version is the full one, just in case we want it later */
/*
SELECT TOP 5 
       ce.[execution_id]
     , ce.[folder_name]
     , ce.[project_name]
     , ce.[package_name]
     , ce.[start_time]
     , ce.[end_time]
	   , DATEDIFF(mi, ce.[start_time],ce.[end_time]) AS ElapsedTimeInMinutes
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
			           WHERE cec.executable_name not like 'SSISOps%'
			             AND cec.execution_id = ce.execution_id
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
			           WHERE executable_name not like 'SSISOps%'
			             AND cet.package_name = ce.package_name
		           ) AS ttte
	     ) AS TotalTasksToExecute
     , ce.[server_name]
     , ce.[machine_name]
     , ce.[total_physical_memory_kb]
     , ce.[available_physical_memory_kb]
     , ce.[total_page_file_kb]
     , ce.[available_page_file_kb]
     , ce.[cpu_count]
  FROM [catalog].[executions] AS ce
 WHERE start_time <= DATEADD(d, -1,GETDATE()) 
 ORDER BY start_time DESC
*/

