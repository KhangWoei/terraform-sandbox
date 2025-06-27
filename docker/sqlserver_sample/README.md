# Note
This is a simple fork of the SqlServer [official image](https://hub.docker.com/r/microsoft/mssql-server) configured to setup some sample databases found in [here](https://learn.microsoft.com/en-us/sql/samples/sql-samples-where-are?view=sql-server-ver17).

Don't forget to set the password, and any other environment variables accessible to the base image.
```
    SA_PASSWORD=<YOUR_PASSWORD>
    ACCEPT_EULA=Y
```
