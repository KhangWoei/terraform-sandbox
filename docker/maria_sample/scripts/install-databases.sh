#!/usr/bin/env bash
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
PASSWORD=$MARIADB_ROOT_PASSWORD

echo Installing Employees...
cd $SCRIPT_DIR/references/employees;
mariadb --host=localhost --user=root --password=$PASSWORD < employees.sql;

echo Installing Sakila...
cd $SCRIPT_DIR/references/sakila;
mariadb  --host=localhost --user=root --password=$PASSWORD < sakila-schema.sql;
mariadb --host=localhost --user=root --password=$PASSWORD < sakila-data.sql;

echo Installing World...
cd $SCRIPT_DIR/references/world;
mariadb --host=localhost --user=root --password=$PASSWORD < world.sql;

echo Done
