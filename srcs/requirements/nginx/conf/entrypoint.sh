#!/bin/bash
set -e

CERT_PATH="/etc/nginx/ssl/cert.pem"
KEY_PATH="/etc/nginx/ssl/key.pem"

if [ ! -f "$CERT_PATH" ] || [ ! -f "$KEY_PATH" ]; then
  echo "[NGINX ENTRYPOINT] Aucun certificat trouvé, génération en cours..."
  openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout "$KEY_PATH" \
    -out "$CERT_PATH" \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=localhost"
else
  echo "[NGINX ENTRYPOINT] Certificat déjà présent, pas de régénération."
fi

exec "$@"

