#!/bin/sh

set -e

cd /var/www/wordpress

until mysql -h mariadb -u $SQL_USER -p$SQL_PASSWORD -e "SELECT 1" > /dev/null 2>&1; do
    echo "Waiting for MariaDB to be ready..."
    sleep 5
done

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
    echo "Creating wp-config.php..."
    wp config create \
        --allow-root \
        --dbname="$SQL_DATABASE" \
        --dbuser="$SQL_USER" \
        --dbpass="$SQL_PASSWORD" \
        --dbhost="$WORDPRESS_DB_HOST":3306 \
        --path='/var/www/wordpress' \
        --locale=fr_FR
fi

if ! wp core is-installed --allow-root --path='/var/www/wordpress'; then
    echo "Installing WordPress..."
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email \
        --allow-root \
        --path='/var/www/wordpress'
fi

if ! wp user exists ${WP_USER_USER}; then
    echo "Creating WordPress user..."
    wp user create "$WP_USER_USER" "$WP_USER_EMAIL" \
        --role=author \
        --user_pass="$WP_USER_PASSWORD" \
        --allow-root \
        --path='/var/www/wordpress'
fi

# redis cache part
echo "Huge thanks to cauvray, real GOAT"
wp config has WP_REDIS_HOST || wp config set WP_REDIS_HOST "redis" --path=/var/www/wordpress
wp config has WP_REDIS_PORT || wp config set WP_REDIS_PORT 6379 --raw --path=/var/www/wordpress
wp config has WP_CACHE || wp config set WP_CACHE true --raw --path=/var/www/wordpress

if ! wp plugin is-installed redis-cache; then
	wp plugin install redis-cache \
		--allow-root \
		--path='/var/www/wordpress'
fi

if ! wp plugin is-active redis-cache; then
	wp plugin activate redis-cache \
		--allow-root \
		--path='/var/www/wordpress'
fi

wp redis enable \
	--allow-root \
	--path='/var/www/wordpress'


mkdir -p /run/php

echo "Starting PHP-FPM..."
exec /usr/sbin/php-fpm83 -F
