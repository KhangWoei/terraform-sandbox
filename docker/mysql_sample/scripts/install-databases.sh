#!/usr/bin/env bash
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

echo Installing Employees...
cd $SCRIPT_DIR/references/employees;
mysql --host=localhost --user=root --password=$MYSQL_ROOT_PASSWORD < employees.sql;

echo Installing Sakila...
cd $SCRIPT_DIR/references/sakila;
mysql  --host=localhost --user=root --password=$MYSQL_ROOT_PASSWORD < sakila-schema.sql;
mysql --host=localhost --user=root --password=$MYSQL_ROOT_PASSWORD < sakila-data.sql;

echo Installing World...
cd $SCRIPT_DIR/references/world;
mysql --host=localhost --user=root --password=$MYSQL_ROOT_PASSWORD < world.sql;

echo Done
