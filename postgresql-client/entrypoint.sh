#!/bin/sh
echo "${DB_HOST}":*:*:"${DB_USER}":"${DB_PASS}" > ~/.pgpass
chmod 0600 ~/.pgpass
psql -h ${DB_HOST} -U ${DB_USER} -w postgres -c "$@"
exit 0