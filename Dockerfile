FROM node:10

RUN apt-get update -y && \
    apt-get install nginx -y

RUN mkdir /var/www/ && mkdir /var/www/app

COPY files/nginx/nginx.conf /etc/nginx/nginx.conf
COPY files/docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
