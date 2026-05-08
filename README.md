Inception

Projet d’administration système et de virtualisation de l’école 42.

Description

Le but du projet est de mettre en place une infrastructure Docker composée de plusieurs services isolés dans des conteneurs :

NGINX avec TLS
WordPress + PHP-FPM
MariaDB

Chaque service fonctionne dans son propre conteneur et communique via des réseaux Docker.

Architecture
                ┌──────────────┐
                │    NGINX     │
                │   (TLS 443)  │
                └──────┬───────┘
                       │
              ┌────────┴────────┐
              │                 │
      ┌───────▼────────┐ ┌──────▼───────┐
      │   WordPress    │ │   MariaDB    │
      │    PHP-FPM     │ │   Database   │
      └────────────────┘ └──────────────┘
Technologies
Docker
Docker Compose
NGINX
WordPress
MariaDB
Debian/Alpine Linux
OpenSSL
Structure du projet
.
├── Makefile
├── secrets/
├── srcs/
│   ├── docker-compose.yml
│   ├── requirements/
│   │   ├── mariadb/
│   │   │   ├── Dockerfile
│   │   │   └── tools/
│   │   ├── nginx/
│   │   │   ├── Dockerfile
│   │   │   └── conf/
│   │   └── wordpress/
│   │       ├── Dockerfile
│   │       └── tools/
│   └── .env
Services
NGINX
Reverse proxy HTTPS
Certificat SSL/TLS
Point d’entrée unique du projet
Ports
443:443
WordPress
PHP-FPM
Communication avec MariaDB
Installation automatique possible via script
MariaDB
Base de données du site WordPress
Volume persistant
Volumes

Les données sont persistées grâce aux volumes Docker :

Base de données MariaDB
Fichiers WordPress

Exemple :

volumes:
  wordpress_data:
  mariadb_data:
Réseaux

Les conteneurs communiquent via un réseau Docker dédié :

networks:
  inception:
