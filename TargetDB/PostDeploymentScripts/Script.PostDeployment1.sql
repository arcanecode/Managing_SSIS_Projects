/*-----------------------------------------------------------------------------------------------*/
-- Post-Deployment Script
--
-- Author..: Robert C. Cain
-- Synopsis: Performs a one time execution of code and scripts after database deployment, in 
--           order to make the database ready to use.
--
-- Description
--   The post deployment script coordinates tasks that need to be done after the database is 
--   deployed. Typically this consists of populating the date dimenstion, then inserting
--   the "missing row" values into the dimensions. 
--   
-- Additional notes from the SQL Project Template
--   This file contains SQL statements that will be appended to the build script.    
--   Use SQLCMD syntax to include a file in the post-deployment script.      
--   Example:      :r .\myfile.sql                
--   Use SQLCMD syntax to reference a variable in the post-deployment script.    
--   Example:      :setvar TableName MyTable              
--                 select * from [$(TableName)]          
--
/*-----------------------------------------------------------------------------------------------*/

exec [App].[PackageRunnerLoad]