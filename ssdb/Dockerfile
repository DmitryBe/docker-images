FROM ubuntu:16.04

# dependency
RUN apt-get update \
    && apt-get install -y autoconf g++ gcc git make cmake python3 python3-pip build-essential \
    && ln -s  /usr/bin/python3 /usr/local/bin/python \
    && ln -s  /usr/bin/pip3 /usr/local/bin/pip

# install ssdb

ENV SSDB_DIR /usr/local/ssdb
RUN mkdir -p ${SSDB_DIR}
WORKDIR ${SSDB_DIR}

RUN mkdir -p /usr/src/ssdb \
    && git clone --depth 1 https://github.com/ideawu/ssdb.git /usr/src/ssdb \
    && make -C /usr/src/ssdb \
    && make -C /usr/src/ssdb install \
    && rm -rf /usr/src/ssdb

# ssdb data path
RUN mkdir /data
VOLUME /data

COPY ./scripts ${SSDB_DIR}/scripts
COPY ./config ${SSDB_DIR}/config

ENTRYPOINT ["./scripts/entry-point.sh"]
