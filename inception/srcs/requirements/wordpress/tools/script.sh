#!/bin/sh

echo "set wp port"
sed -i "s/listen = 0.0.0.0:s/listen = 0.0.0.0:${WP_PORT}/g" /etc/php81/php-fpm.d/www.conf

echo "wait to connect mariadb"
/usr/local/bin/wait-for-it.sh $MARIADB_DB_HOST:$MARIADB_PORT --timeout=15

echo "set wp"
if [ ! -f /var/www/html/wp-config.php ]; then
  wp core download --allow-root --path=/var/www/html --force
  wp config create --allow-root --path=/var/www/html --dbhost=$MARIADB_DB_HOST:$MARIADB_PORT --dbname=$MARIADB_DB_NAME --dbuser=$MARIADB_DB_USER --dbpass=$MARIADB_DB_PASS --force
  wp db create --allow-root --path=/var/www/html
  wp core install --allow-root --path=/var/www/html --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN_NAME --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email
  wp user create --path=/var/www/html $WP_USER_NAME $WP_USER_EMAIL --user_pass=$WP_USER_PASS --role=author
  wp theme activate --path=/var/www/html twentytwentytwo
fi

echo "start php-fpm"
exec "$@"