#!/bin/bash
set -e

echo "[ENTRYPOINT] Vérification des fichiers WordPress..."

# Si le dossier est vide, on télécharge WordPress
if [ ! -f wp-config-sample.php ]; then
    echo "[ENTRYPOINT] WordPress non trouvé. Téléchargement..."
    curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz
    tar -xzf /tmp/wordpress.tar.gz -C /tmp/
    cp -a /tmp/wordpress/. /var/www/html/
    rm -rf /tmp/wordpress /tmp/wordpress.tar.gz
    chown -R www-data:www-data /var/www/html
    cd /var/www/html
fi

# Création de wp-config.php si absent
if [ ! -f /var/www/html/index.php ]; then
    echo "[ENTRYPOINT] Création de wp-config.php..."
    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
    sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/" /var/www/html/wp-config.php
    sed -i "s/username_here/${WORDPRESS_DB_USER}/" /var/www/html/wp-config.php
    sed -i "s/password_here/${WORDPRESS_DB_PASSWORD}/" /var/www/html/wp-config.php
    sed -i "s/localhost/${WORDPRESS_DB_HOST}/" /var/www/html/wp-config.php
fi

mkdir -p /run/php

echo "[ENTRYPOINT] Démarrage de php-fpm..."
exec php-fpm7.4 -F

