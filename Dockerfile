FROM node
MAINTAINER Brian Vallelunga <vallelungabrian@gmail.com>

RUN mkdir /easybin
WORKDIR /easybin
COPY . /easybin/
RUN bash scripts/initialize.sh

EXPOSE 1337
CMD ["coffee", "/easybin/start.coffee"]
