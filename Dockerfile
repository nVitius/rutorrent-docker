FROM debian:jessie

WORKDIR /tmp

VOLUME /config

EXPOSE 80

RUN apt-get update && apt-get install -y nginx php5 php5-fpm curl

RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/' /etc/php5/fpm/php.ini

RUN curl -L https://github.com/Novik/ruTorrent/archive/master.tar.gz | tar -zx && \
    mv /tmp/ruTorrent-master /var/www/rutorrent && \
    rm -rf /var/www/rutorrent/conf && \
    ln -s /config/rutorrent_conf /var/www/rutorrent/conf && \
    chown www-data:www-data --recursive /var/www/

RUN rm /etc/nginx/sites-enabled/default && \
    ln -s /etc/nginx/sites-available/rutorrent.conf /etc/nginx/sites-enabled/rutorrent.conf

COPY nginx.conf /etc/nginx/
COPY rutorrent.conf /etc/nginx/sites-enabled/
COPY rutorrent_conf /config/rutorrent_conf/
