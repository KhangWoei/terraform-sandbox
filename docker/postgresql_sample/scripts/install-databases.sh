#!/usr/bin/env bash
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

echo Installing Pagila...
cd $SCRIPT_DIR/references/pagila;

psql -U postgres -d postgres -c "CREATE DATABASE \"Pagila\";"
psql -U postgres -d Pagila < schema.sql;
psql -U postgres -d Pagila < data.sql;

echo Installing AdventureWorks...
cd $SCRIPT_DIR/references/adventureworks;
psql -U postgres -d postgres -c "CREATE DATABASE \"Adventureworks\";"
psql -U postgres -d Adventureworks < install.sql;

echo Installing Chinook...
cd $SCRIPT_DIR/references/chinook;
psql -U postgres -d postgres -c "CREATE DATABASE \"Chinook\";"
psql -U postgres -d Chinook < Chinook.sql;

echo Done
