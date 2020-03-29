/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

PRINT 'Data Load Simulation: Deactivate Temporal Tables before Data Load'
GO
EXEC DataLoadSimulation.DeactivateTemporalTablesBeforeDataLoad;
GO

:r .\pds100-ins-app-people.sql

PRINT 'Data Load Simulation: Reactivate Temporal Tables after Data Load'
GO
EXEC DataLoadSimulation.ReactivateTemporalTablesAfterDataLoad;
GO
