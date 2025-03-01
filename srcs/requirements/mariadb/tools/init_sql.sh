#!/bin/sh

set -e

/usr/bin/mariadbd-safe --datadir=/var/lib/mysql &

until mariadb-admin ping --silent; do
	sleep 2
done

# Debugging: Print environment variables to verify
echo "SQL_DATABASE: $SQL_DATABASE"
echo "SQL_USER: $SQL_USER"
echo "SQL_PASSWORD: $SQL_PASSWORD"
echo "SQL_ROOT_PASSWORD: $SQL_ROOT_PASSWORD"

# Run the SQL script
if [ -f "/tools/init.sql" ]; then
	envsubst < /tools/init.sql | mariadb
fi

wait
