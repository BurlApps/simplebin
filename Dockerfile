FROM node
MAINTAINER Brian Vallelunga <vallelungabrian@gmail.com>

RUN mkdir /enjoypnd
WORKDIR /enjoypnd
COPY . /enjoypnd/
RUN bash scripts/initialize.sh

EXPOSE 1337
CMD ["coffee", "/enjoypnd/start.coffee"]
