/*---------------------------------------------------------------------------*/
/* Get a summary of package executions by execution status                   */
/* Number running, failed, success, etc.                                     */
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

DECLARE @pFromDate DateTime
      , @pThruDate DateTime
      , @pFolderNameContains NVarChar(max)
      , @pProjectNameContains NVarChar(max)
      , @pPackageNameContains NVarChar(max);

-- Default to all runs since midnight
SET @pFromDate = DATEADD(day, DATEDIFF(day, 1, GETDATE()), 0);
SET @pThruDate = DATEADD(day, 2, @pFromDate);

SET @pFolderNameContains=N'DEMO_SSIS';
SET @pProjectNameContains=N'DEMO_SSIS';

-- Leave the package blank (or comment out the line) to do counts for all packages
-- SET @pPackageNameContains=N'Master.dtsx';

WITH filtered AS
(
	SELECT [status] FROM [catalog].[executions]
   WHERE ([start_time] IS NULL OR CONVERT (datetime, [start_time]) >= @pFromDate) 
     AND ([start_time] IS NULL OR CONVERT (datetime, [start_time]) <= DATEADD(day,1,@pThruDate)) 
     AND (ISNULL([folder_name], '') LIKE 
           (CASE WHEN ISNULL(@pFolderNameContains, '') COLLATE database_default != '' COLLATE database_default  
                 THEN REPLACE(REPLACE(REPLACE(@pFolderNameContains COLLATE database_default,'[', '[[]'), '_', '[_]'), '%','[%]') COLLATE database_default 
                 ELSE ISNULL([folder_name], '') 
             END
           )
         ) 
     AND (ISNULL([project_name],'') LIKE 
           (CASE WHEN ISNULL(@pProjectNameContains, '') COLLATE database_default != '' COLLATE database_default  
                 THEN REPLACE(REPLACE(REPLACE(@pProjectNameContains COLLATE database_default,'[', '[[]'), '_', '[_]'), '%','[%]') COLLATE database_default 
                 ELSE ISNULL([project_name], '') 
             END
           )
         )
     AND (ISNULL([package_name],'') LIKE 
           (CASE WHEN ISNULL(@pPackageNameContains, '') COLLATE database_default != '' COLLATE database_default  
                 THEN REPLACE(REPLACE(REPLACE(@pPackageNameContains COLLATE database_default,'[', '[[]'), '_', '[_]'), '%','[%]') COLLATE database_default 
                 ELSE ISNULL([package_name], '') 
             END
           )
         ) 
)
SELECT 
  (SELECT COUNT(1) FROM filtered) AS nAll,
  (SELECT COUNT(1) FROM filtered WHERE [status] = 2) AS nRunning,
  (SELECT COUNT(1) FROM filtered WHERE [status] = 4) AS nFailed,
  (SELECT COUNT(1) FROM filtered WHERE [status] = 7) AS nSuccess,
  (SELECT COUNT(1) FROM filtered WHERE [status] != 2 AND [status] != 4 AND [status] != 7) AS nOthers
