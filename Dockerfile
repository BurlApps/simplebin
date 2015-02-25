FROM node
MAINTAINER Brian Vallelunga <vallelungabrian@gmail.com>

RUN mkdir /simplebin
WORKDIR /simplebin
COPY . /simplebin/
RUN bash scripts/initialize.sh

EXPOSE 1337
CMD ["coffee", "/simplebin/start.coffee"]
