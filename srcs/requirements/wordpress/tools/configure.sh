#!/bin/sh

# Wait for mysql
while ! mariadb -h$MYSQL_HOST -u$WP_DATABASE_USR -p$WP_DATABASE_PWD $WP_DATABASE_NAME &>/dev/null; do
    sleep 3
done

if [ ! -f "/var/www/html/index.html" ]; then

    # Move to the right path the HTML file
    mv /tmp/index.html /var/www/html/index.html

    # Wordpress download
    wp core download --allow-root

    # Wp-config.php file creation
    if [ ! -e /var/www/html/wordpress/wp-config.php ]; then
    
        wp config create --dbname=$WP_DATABASE_NAME --dbuser=$WP_DATABASE_USR --dbpass=$WP_DATABASE_PWD --dbhost=$MYSQL_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
    fi
    
    # Admin creation
    if [ ! `wp option get siteurl --path='/var/www/html/wordpress' > /dev/null 2>&1` ]; then    
    
        wp core install --url=$DOMAIN_NAME/wordpress --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
    fi    
        
    # User creation
    if [ ! `wp user get $WP_USER --path='/var/www/html/wordpress' > /dev/null 2>&1` ]; then
    
        wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root
    fi
    
    wp theme install inspiro --activate --allow-root

fi

echo "Wordpress started on :9000"
/usr/sbin/php-fpm7 -F -R