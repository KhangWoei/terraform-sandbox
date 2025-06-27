#!/usr/bin/env bash
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

echo Installing OT...
sqlplus system/$ORACLE_PWD@localhost/FREEPDB1 << EOF
CREATE USER OT IDENTIFIED BY $ORACLE_PWD;
GRANT CONNECT, RESOURCE, DBA TO OT;
CONNECT OT/$ORACLE_PWD@FREEPDB1;

@$SCRIPT_DIR/references/ot/ot_schema.sql
@$SCRIPT_DIR/references/ot/ot_data.sql
EXIT;
EOF

echo Installing O7...
sqlplus system/$ORACLE_PWD@localhost/FREEPDB1 << EOF
CREATE USER O7 IDENTIFIED BY $ORACLE_PWD;
GRANT CONNECT, RESOURCE, DBA TO O7;
CONNECT O7/$ORACLE_PWD@FREEPDB1;

@$SCRIPT_DIR/references/o7/O7.sql
EXIT;
EOF

echo Done
