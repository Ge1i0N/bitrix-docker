#!/bin/sh

mysql_note "Granting SYSTEM_VARIABLES_ADMIN privilege to user '${MYSQL_USER}'"

docker_process_sql --database=mysql <<-EOSQL
  GRANT SYSTEM_VARIABLES_ADMIN ON *.* TO '${MYSQL_USER}'@'%';
  FLUSH PRIVILEGES;
EOSQL
