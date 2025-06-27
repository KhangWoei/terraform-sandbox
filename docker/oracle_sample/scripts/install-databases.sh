#!/usr/bin/env bash
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
password=$ORACLE_PWD

echo Installing OT...
sqlplus system/$password@localhost/FREEPDB1 << EOF
CREATE USER OT IDENTIFIED BY $password;
GRANT CONNECT, RESOURCE, DBA TO OT;
CONNECT OT/$password@FREEPDB1;

@$SCRIPT_DIR/references/ot/ot_schema.sql
@$SCRIPT_DIR/references/ot/ot_data.sql
EXIT;
EOF

echo Installing O7...
sqlplus system/$password@localhost/FREEPDB1 << EOF
CREATE USER O7 IDENTIFIED BY $password;
GRANT CONNECT, RESOURCE, DBA TO O7;
CONNECT O7/$password@FREEPDB1;

@$SCRIPT_DIR/references/o7/O7.sql
EXIT;
EOF

echo Done
