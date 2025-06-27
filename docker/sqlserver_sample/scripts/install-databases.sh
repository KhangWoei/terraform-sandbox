#!/usr/bin/env bash
#we need to wait for sqlserver to finish initializing 
echo Waiting for SQL Server to initialize...
sleep 30s

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
PASSWORD=$SA_PASSWORD

echo Installing AdventureworksDW...
/opt/mssql-tools/bin/sqlcmd -H localhost -U sa -P $PASSWORD -d master -Q "RESTORE DATABASE [AdventureWorksDW] FROM DISK = N'$SCRIPT_DIR/references/adventureworks/AdventureWorksDW.bak' WITH MOVE 'AdventureWorksDW2017' TO '/var/opt/mssql/data/AdventureWorksDW.mdf', MOVE 'AdventureWorksDW2017_log' TO '/var/opt/mssql/data/AdventureWorksDW.ldf'"

echo Installing AdventureworksLT...
/opt/mssql-tools/bin/sqlcmd -H localhost -U sa -P $PASSWORD -d master -Q "RESTORE DATABASE [AdventureWorksLT] FROM DISK = N'$SCRIPT_DIR/references/adventureworks/AdventureWorksLT.bak' WITH MOVE 'AdventureWorksLT2012_Data' TO '/var/opt/mssql/data/AdventureWorksLT.mdf', MOVE 'AdventureWorksLT2012_Log' TO '/var/opt/mssql/data/AdventureWorksLT.ldf'"

echo Installing WideWorldImportersDW...
/opt/mssql-tools/bin/sqlcmd -H localhost -U sa -P $PASSWORD -d master -Q "RESTORE DATABASE [WideWorldImportersDW] FROM DISK = N'$SCRIPT_DIR/references/wideworldimporters/WideWorldImportersDW.bak' WITH MOVE 'WWI_Primary' TO '/var/opt/mssql/data/WideWorldImportersDW_Primary.mdf', MOVE 'WWI_UserData' TO '/var/opt/mssql/data/WideWorldImportersDW_UserData.ndf', MOVE 'WWI_Log' TO '/var/opt/mssql/data/WideWorldImportersDW.ldf', MOVE 'WWIDW_InMemory_Data_1' TO '/var/opt/mssql/data/WideWorldImportersDW_FileStream'"

echo Installing Northwind...
/opt/mssql-tools/bin/sqlcmd -H localhost -U sa -P $PASSWORD -d master -i $SCRIPT_DIR/references/northwind/Northwind.sql

echo Installing Chinook...
/opt/mssql-tools/bin/sqlcmd -H localhost -U sa -P $PASSWORD -d master -i $SCRIPT_DIR/references/chinook/Chinook.sql

echo Done

