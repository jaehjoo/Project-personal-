#!/bin/sh

echo "set mariadb port"
sed -i "s/port/port = ${MARIADB_PORT}/g" /etc/my.cnf

echo "set mariadb basic info"
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
fi

echo "start mariadb background"
/usr/bin/mysqld_safe --datadir=/var/lib/mysql &

echo "check to start mariadb"
until mysqladmin ping -u root >/dev/null 2>&1; do
    sleep 1
done

echo "set mariadb config"
envsubst < /usr/local/bin/wordpress.sql | mysql -u root 

echo "kill mariadb background"
pkill mariadb

echo "check to die mariadb"
while pgrep mariadb > /dev/null; do
    sleep 1
done

echo "start mariadb foreground"
exec "$@"