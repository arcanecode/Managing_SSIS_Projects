/*---------------------------------------------------------------------------*/
/* This script will get the number of package executions, and the average    */
/* exeuction time per package. Use the where clause to limit the query,      */
/* most typically for a single package.                                      */
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

-- Default to all runs since midnight
SET @pFromDate = DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0);
SET @pThruDate = DATEADD(day, 1, @pFromDate);


SELECT CAST(ce.start_time AS DATE) AS ExecutionDate
     , AVG((DATEDIFF(s,  ce.[start_time],ce.[end_time]) / 60.0)) AS AverageExecutionTimeMinutes
     , COUNT(*) AS NumberExecutions
  FROM [SSISDB].[catalog].[executions] ce
 WHERE ce.start_time
       BETWEEN CAST(CAST(CAST(@pFromDate AS DATE) AS VARCHAR) + ' 00:00:00' AS DATETIME) 
           AND CAST(CAST(CAST(@pThruDate AS DATE) AS VARCHAR) + ' 23:59:59' AS DATETIME)
--   AND ce.package_name = 'Master.dtsx'    -- Enter a package to limit to just one package
 GROUP BY CAST(start_time AS DATE)

