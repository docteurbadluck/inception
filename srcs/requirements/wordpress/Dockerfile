FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    php php-fpm php-mysql php-gd php-curl php-xml php-mbstring \
    wget unzip mariadb-client curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

COPY conf/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|' /etc/php/*/fpm/pool.d/www.conf

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm7.4", "-F"]

