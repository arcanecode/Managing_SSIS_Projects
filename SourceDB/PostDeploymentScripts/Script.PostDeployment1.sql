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
:r .\pds110-ins-app-countries.sql
:r .\pds140-ins-app-stateprovinces.sql
:r .\pds142-upd-app-stateprovinces-borders.sql
:r .\pds150-ins-app-cities.sql

-- This loads the rest of the cities, however they
-- are optional to load. You can comment these out
-- without negative effects

:r .\pds150-ins-app-cities-a.sql
:r .\pds150-ins-app-cities-b.sql
:r .\pds150-ins-app-cities-c.sql
:r .\pds150-ins-app-cities-d.sql
:r .\pds150-ins-app-cities-e.sql
:r .\pds150-ins-app-cities-f.sql
:r .\pds150-ins-app-cities-g.sql
:r .\pds150-ins-app-cities-h.sql
:r .\pds150-ins-app-cities-i.sql
:r .\pds150-ins-app-cities-j.sql
:r .\pds150-ins-app-cities-k.sql
:r .\pds150-ins-app-cities-l.sql
:r .\pds150-ins-app-cities-m.sql
:r .\pds150-ins-app-cities-n.sql
:r .\pds150-ins-app-cities-o.sql
:r .\pds150-ins-app-cities-p.sql
:r .\pds150-ins-app-cities-q.sql
:r .\pds150-ins-app-cities-r.sql
:r .\pds150-ins-app-cities-s.sql
:r .\pds150-ins-app-cities-t.sql
:r .\pds150-ins-app-cities-u.sql
:r .\pds150-ins-app-cities-v.sql
:r .\pds150-ins-app-cities-w.sql
:r .\pds150-ins-app-cities-x.sql
:r .\pds150-ins-app-cities-y.sql
:r .\pds150-ins-app-cities-z.sql


:r .\pds151-ins-post-app-cities.sql

PRINT 'Data Load Simulation: Reactivate Temporal Tables after Data Load'
GO
EXEC DataLoadSimulation.ReactivateTemporalTablesAfterDataLoad;
GO
