#!/bin/bash

apt install postgresql postgresql-client -y

pw=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | fold -w 32 | head -n 1)

su postgres -c psql <<EOF
DO \$\$
BEGIN
  IF EXISTS (SELECT FROM pg_roles WHERE rolname='admin') THEN
    ALTER ROLE admin WITH PASSWORD '$pw';
  ELSE
    CREATE ROLE admin SUPERUSER PASSWORD '$pw';
    ALTER ROLE admin LOGIN;
    ALTER ROLE admin CREATEDB;
  END IF;
END \$\$;
EOF

echo "The generated password for admin is: $pw"

pg_isready -h localhost -p 5432

