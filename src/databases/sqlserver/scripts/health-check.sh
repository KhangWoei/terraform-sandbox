#!/bin/bash

CONTAINER_ID=$1
SQL_SERVER_VERSION=$2
MSSQL_SA_PASSWORD=$3

if [ $SQL_SERVER_VERSION -lt 2018 ]
then 
    HEALTHCHECK=(/opt/mssql-tools/bin/sqlcmd -H ${CONTAINER_ID} -U sa -P ${MSSQL_SA_PASSWORD} -d master -l 2 -Q 'SELECT 1')
else
    HEALTHCHECK=(/opt/mssql-tools18/bin/sqlcmd -H ${CONTAINER_ID} -U sa -P ${MSSQL_SA_PASSWORD} -d master -l 2 -Q 'SELECT 1' -No)
fi
 
"${HEALTHCHECK[@]}"

