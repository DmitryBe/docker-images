FROM localhost:5000/ds-dev/dsspark:2.1.1-0.2.0

# requiremenets
RUN apt-get update \
    && apt-get install -y wget bash snappy 

# flink env
ENV FLINK_HOME /opt/flink
ENV PATH $PATH:$FLINK_HOME/bin

# install flink
RUN mkdir -p /tmp/flink && cd /tmp/flink \
    && wget http://www-us.apache.org/dist/flink/flink-1.3.2/flink-1.3.2-bin-hadoop27-scala_2.11.tgz \
    && mkdir -p ${FLINK_HOME} \
    && tar -xzf flink-1.3.2-bin-hadoop27-scala_2.11.tgz -C ${FLINK_HOME} --strip-components=1 \
    && rm -rf /tmp/flink 

COPY scripts/bootstrap.sh /

RUN echo 'tail -f /etc/hosts' >> $FLINK_HOME/bin/mesos-taskmanager.sh

# create user and group
#RUN addgroup -S flink && adduser -D -S -H -G flink -h $FLINK_HOME flink \
#   && chown -R flink:flink $FLINK_HOME \
#   && chown -h flink:flink $FLINK_HOME

#USER flink

