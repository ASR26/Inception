#!/bin/bash

touch init.sql

echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;" > init.sql
echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';" >> init.sql
echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';" >> init.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS';" >> init.sql
echo "FLUSH PRIVILEGES;" >> init.sql

chmod 755 init.sql

mv init.sql /var/lib/mysql/init.sql

chown -R mysql:root /var/lib/mysql/init.sql

mariadbd --init-file /var/lib/mysql/init.sql