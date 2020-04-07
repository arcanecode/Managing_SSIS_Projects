/*---------------------------------------------------------------------------*/
/* Produces a listing of all packages in the catalog                         */
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

USE SSISDB;

SELECT cfd.name AS Folder
     , cpr.[name] AS Project
     , cpk.[name] AS Package
     , cfd.folder_id
     , cpk.[project_id]
     , cpk.[package_id]
     , cpk.[package_guid]
     , cpk.[description]
     , CAST(cpk.[package_format_version] AS NVARCHAR)
       + '.' + CAST(cpk.[version_major] AS NVARCHAR)
       + '.' + CAST(cpk.[version_minor] AS NVARCHAR)
       AS PackageVersion
     , cpk.[version_build]
     , cpk.[version_guid]
  FROM [SSISDB].[catalog].[packages] cpk
  JOIN [SSISDB].[catalog].[projects] cpr
    ON cpk.[project_id] = cpr.[project_id]
  JOIN [SSISDB].[catalog].[folders] cfd
    ON cpr.folder_id = cfd.folder_id
 ORDER BY cfd.[name], cpr.[name], cpk.[name]