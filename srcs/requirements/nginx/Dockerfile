FROM debian:bullseye

RUN apt-get update && apt-get upgrade && apt install -y nginx && apt install openssl -y

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

COPY ./tools/script.sh /nginx_script.sh

RUN chmod +x nginx_script.sh

CMD [ "./nginx_script.sh" ]