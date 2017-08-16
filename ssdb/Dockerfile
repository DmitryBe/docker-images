FROM ubuntu:16.04

ENV APP_DIR /usr/local/ssdb/
WORKDIR ${APP_DIR}

RUN apt-get update \
    && apt-get install -y autoconf g++ gcc git make  \
    && mkdir -p /usr/src/ssdb \
    && git clone --depth 1 https://github.com/ideawu/ssdb.git /usr/src/ssdb \
    && make -C /usr/src/ssdb \
    && make -C /usr/src/ssdb install \
    && rm -rf /usr/src/ssdb \

# config
RUN mkdir /config
ADD ssdb.conf /config/

# endpoint
EXPOSE 8888

# store data
RUN mkdir /data
VOLUME /data

CMD ["/usr/local/ssdb/ssdb-server", "/config/ssdb.conf"]
