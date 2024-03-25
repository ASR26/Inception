FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y && apt-get install mariadb-server -y

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/script.sh /mariadb_script.sh

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /var/lib/mysql /run/mysqld /tmp && chmod +x /mariadb_script.sh

CMD ["./mariadb_script.sh"]
