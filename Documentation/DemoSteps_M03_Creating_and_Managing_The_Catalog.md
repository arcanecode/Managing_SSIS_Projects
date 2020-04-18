# Module 3 - Creating and Managing the Catalog

## Demo 1 - Creating the Catalog

1. Open SSMS. Connect to your localhost (or the name of your server).
2. In the object explorer locate the branch that reads *Integration Services Catalogs*.
3. Click the + button beside it, and you will see nothing appear.
4. Right click on the Integration Services Catalogs branch.
5. In the menu, pick _Create Catalog..._
6. Place a check mark beside _Enable CLR Integration_
7. If you plan to allow automatic execution of SSIS at SQL Server startup, place a check mark beside that option.
8. Accept the default name of SSISDB for the catalog.
9. Enter, then retype a password. _Make sure you write this down, or save it in your password manager!_
10. Accept the remaining defaults, and click the OK button.

## Demo 2 - Backup the SSISDB

Prior to doing this, you will:

1. Need to launch SSMS in Admin mode.
2. In file explorer, navigate to the folder _C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup_. When you get to the backup folder, you may be prompted you don't have permission. Grant your user ID permissions to the folder.

To backup:

1. Under the Integration Services Catalogs branch, you now see SSISDB. This is the interface by which you can navigate to your deployed SSIS Projects. We will see more on this later in the course.
2. Move to Databases and expand (you may need to refresh if it is already been expanded).
3. Start by backing up the database.

Using the menus:

1. Right click on the database.
2. In the menu, pick Tasks, then Backup.
3. Click OK to do the backup. (Make sure to change the backup location to the backups folder.)

Using a script:

Instead of the menus, you can use the following script. 

```sql
BACKUP DATABASE [SSISDB] TO  
DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\SSISDBBackup.bak' 
WITH NOFORMAT
   , NOINIT
   , NAME = N'SSISDB-Full Database Backup'
   , SKIP
   , NOREWIND
   , NOUNLOAD
   , STATS = 10
GO
```

## Demo 3 - Backup the encryption key

After backing up the database, you will also need to backup the encryption key. The key is used to encrypt things like connection strings. When you restore the SSIS database, if you don't also restore the encryption keys you will be forced to re-setup all the connection strings, passwords, and other sensitive informaiton.

To backup the encryption key, use the following command:

```sql
USE SSISDB
GO

-- If the file already exists you will get an error!
BACKUP MASTER KEY TO FILE = 'c:\temp\DemoTestKey'  
  ENCRYPTION BY PASSWORD = 'SecureP@ssW0rd'  
GO
```

## Demo 4 - Restore

To restore a SSISDB to a server where an SSIS catalog had already been created, restore the database normally. 

If you have a backup of the database master key, and you know the password used to encrypt it, you can restore the encryption key with the following command:

```sql
USE SSISDB
GO

RESTORE MASTER KEY FROM FILE= 'c:\temp\DemoTestKey'
  DECRYPTION BY PASSWORD = 'SecureP@ssW0rd' -- 'Password used to encrypt the master key during SSISDB backup'  
  ENCRYPTION BY PASSWORD = 'SecureP@ssW0rd' -- 'New Password'  
  FORCE
GO
```

---

> If you are restoring the database to a new server, the Microsoft Docs has a good article on all the steps involved at [Backup, Restore, and Move the SSIS Catalog](https://docs.microsoft.com/en-us/sql/integration-services/backup-restore-and-move-the-ssis-catalog?view=sql-server-2014&viewFallbackFrom=sql-server-ver15)

[Return to the DemoSteps document](DemoSteps.md)
