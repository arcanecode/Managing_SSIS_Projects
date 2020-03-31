-- Application Schema
-- Holds items generic to entire data warehouse
create schema [App]
    authorization [dbo];
GO

execute sp_addextendedproperty @name = 'Description'
      , @value = 'Application configuration code'
      , @level0type = 'SCHEMA'
      , @level0name = 'App';
