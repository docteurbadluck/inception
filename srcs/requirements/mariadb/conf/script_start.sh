#!/bin/sh
set -e

# Crée les dossiers nécessaires
mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

# Initialise la base de données si ce n’est pas déjà fait
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initialisation de la base de données..."
    mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
fi

# Démarre MariaDB en arrière-plan
echo "Démarrage de mysqld_safe..."
mysqld_safe &

# Attend que MariaDB soit prêt
echo "Attente que MariaDB démarre..."
while ! mysqladmin ping --silent --wait=1; do
    sleep 1
done

# Création de la base de données et de l'utilisateur
echo "MariaDB est prêt. Création des bases et utilisateurs..."

mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

# Garde MariaDB en avant-plan
wait

