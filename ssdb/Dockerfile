FROM alpine:latest

RUN apk add --no-cache --upgrade --virtual .build-deps autoconf g++ gcc git make \
  && mkdir -p /usr/src/ssdb \
  && git clone --depth 1 https://github.com/ideawu/ssdb.git /usr/src/ssdb \
  && make -C /usr/src/ssdb \
  && make -C /usr/src/ssdb install \
  && rm -rf /usr/src/ssdb \
  && apk del .build-deps 

COPY ssdb.conf /usr/local/ssdb/ssdb.conf

EXPOSE 8888

RUN mkdir /data

VOLUME /data

WORKDIR /data

CMD ["/usr/local/ssdb/ssdb-server", "/usr/local/ssdb/ssdb.conf"]
