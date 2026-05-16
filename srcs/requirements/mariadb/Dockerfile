FROM debian:bullseye

RUN apt update -y
RUN apt upgrade -y
RUN apt-get install mariadb-server -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY conf/script_start.sh .

# Création du dossier pour le socket MySQL (sinon mysqld échoue à le créer)
RUN mkdir -p /run/mysqld && \
    chown mysql:mysql /run/mysqld

RUN chmod +x /script_start.sh

ENTRYPOINT ["/script_start.sh"]
