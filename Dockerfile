FROM debian:jessie

WORKDIR /tmp

RUN apt-get update && apt-get install -y nginx php5 php5-fpm curl

RUN curl -L https://github.com/Novik/ruTorrent/tarball/master | tar -zx
