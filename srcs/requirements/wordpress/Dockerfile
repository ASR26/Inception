FROM debian:bullseye

RUN apt update -y 

RUN apt-get update && apt-get upgrade \
	&& apt-get -y install php7.4 php7.4-mysql php7.4-fpm && apt-get -y install mariadb-client curl \
	&& mkdir -p /var/www/wordpress && chown -R root:root /var/www/wordpress && chmod -R 755 /var/www/wordpress \
	&& curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

COPY ./tools/script.sh ./wp_script.sh

RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp


RUN chmod +x ./wp_script.sh

EXPOSE 9000


CMD [ "./wp_script.sh" ]