# Inception

> System administration and containerization project from 42 school.

<div align="center">
  <img width="320" height="300" alt="docker" src="https://github.com/user-attachments/assets/1d87e67b-dc3e-45d5-b7fd-036aaa294502" />
</div>

---

## Architecture

<div align="center">
  <img width="500" height="255" alt="architecture" src="https://github.com/user-attachments/assets/c22fb3fd-1b6e-4a94-b099-91bbf57de8d0" />
</div>

## Demo

https://github.com/user-attachments/assets/dc72accd-98fb-45a3-b6d5-13b8256f4fea

---

## Overview

Inception sets up a multi-container Docker infrastructure where each service runs in its own isolated container and communicates through dedicated Docker networks:

| Service | Role |
|---------|------|
| **NGINX** | Reverse proxy with TLS (port 443) — only public entry point |
| **WordPress + PHP-FPM** | Application server, on `front` and `back` networks |
| **MariaDB** | Database, isolated on the `back` network only |

Network isolation ensures the database is never directly reachable from outside.

## Prerequisites

- Docker & Docker Compose
- `make`

## Installation

```bash
git clone https://github.com/docteurbadluck/inception.git
cd inception
```

Create a `.env` file at `srcs/.env`:

```env
WORDPRESS_DB_NAME=wordpress
WORDPRESS_DB_USER=wpuser
WORDPRESS_DB_PASSWORD=yourpassword
MYSQL_ROOT_PASSWORD=yourrootpassword
USER=your_unix_username
```

## Usage

```bash
make        # Build and start all services
make down   # Stop and remove containers
make clean  # Remove containers, volumes, and built images
```

The site is served at `https://localhost`.

## Project Structure

```
srcs/
├── docker-compose.yml
├── .env
└── requirements/
    ├── nginx/
    ├── wordpress/
    └── mariadb/
```
