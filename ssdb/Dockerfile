FROM ubuntu:16.04

ENV APP_DIR /usr/local/ssdb
RUN mkdir -p ${APP_DIR}

WORKDIR ${APP_DIR}

RUN apt-get update \
    && apt-get install -y autoconf g++ gcc git make python \
    && mkdir -p /usr/src/ssdb \
    && git clone --depth 1 https://github.com/ideawu/ssdb.git /usr/src/ssdb \
    && make -C /usr/src/ssdb \
    && make -C /usr/src/ssdb install \
    && rm -rf /usr/src/ssdb 

COPY ./scripts ${APP_DIR}/scripts
COPY ./config ${APP_DIR}/config

# ssdb data path
RUN mkdir /data
VOLUME /data

ENTRYPOINT ["./scripts/entry-point.sh"]
