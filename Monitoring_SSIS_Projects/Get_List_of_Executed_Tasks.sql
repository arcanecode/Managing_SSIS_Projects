/*---------------------------------------------------------------------------*/
/* Get a list of tasks that have executed                                    */
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

SELECT DISTINCT 
       [executable_id]
     , [executable_name]
     , [executable_guid]
     , [package_name]
     , [package_path]
  FROM [SSISDB].[catalog].[executables]
  --and package_name = 'Master.dtsx'        

-- Note, if you are using BIxPress, you should add the following WHERE clause
-- to omit it's logging operations
-- WHERE executable_name not like 'SSISOps%'
 


/*---------------------------------------------------------------------------*/
/* Count the number of tasks executed                                        */
/* You can add where criteria to find out things like the number of times    */
/* a package or specific task executed.                                      */
/*---------------------------------------------------------------------------*/
SELECT COUNT(*) 
FROM (SELECT Distinct [executable_id]
      ,[execution_id]
      ,[executable_name]
      ,[executable_guid]
      ,[package_name]
      ,[package_path]
  FROM [SSISDB].[catalog].[executables]
--  and execution_id = 30799
--  and package_name = 'Master.dtsx'
  ) AS x

-- Note, if you are using BIxPress, you should add the following WHERE clause
-- to omit it's logging operations
-- WHERE executable_name not like 'SSISOps%'
