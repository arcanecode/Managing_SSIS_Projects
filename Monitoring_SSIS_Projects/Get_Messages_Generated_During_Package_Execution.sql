/*---------------------------------------------------------------------------*/
/* Get a list of messages generated during package execution.                */
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

SELECT package_name
     , event_name
     , [message]
     , execution_path
     , event_message_id
     , operation_id
     , message_type
     , message_source_type
     , message_source_name
     , message_source_id
     , package_path
     , threadID
  FROM catalog.event_messages
 WHERE event_name = 'OnPostExecute'            -- Limit event types
 and message_source_type=30
 -- and operation_id = 30799                   -- Use to filter for just a single package execution

