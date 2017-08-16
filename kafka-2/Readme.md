
Docker infra
```
# zk

docker run -itd --name zookeeper -p 2181:2181 zookeeper

# kafka broker (https://hub.docker.com/r/ches/kafka/)

docker run -it \
    --name kafka \
    --hostname localhost \
    --link zookeeper:zookeeper \
    -p 9092:9092 \
    -v `pwd`/data:/data -v `pwd`/logs:/logs \
    --env KAFKA_ADVERTISED_HOST_NAME=127.0.0.1 \
    --env ZOOKEEPER_IP=127.0.0.1 \
    --env ZOOKEEPER_CHROOT=/kafka_v_0_10 \
    --env KAFKA_DEFAULT_REPLICATION_FACTOR=1 \
    dmitryb/kafka-0.10.2.1:1.0
```

Kafka tools
```
# test kafka (start kafka client) - https://kafka.apache.org/documentation/

docker run -it --rm --hostname localhost --net=host dmitryb/kafka-0.10.2.1:1.0 bash

## list topics
kafka-topics.sh --list --zookeeper localhost:2181/kafka_v_0_10
kafka-topics.sh --list --zookeeper 10.59.54.99:2181/kafka_dev

## create topic 

kafka-topics.sh --create --zookeeper localhost:2181/kafka_v_0_10 --replication-factor 1 --partitions 1 --topic test-topic-2
kafka-topics.sh --create --zookeeper 10.59.54.99:2181/kafka_dev --replication-factor 1 --partitions 2 --topic test-topic-1

## delete topic 

kafka-topics.sh --delete --force --zookeeper localhost:2181/kafka_v_0_10 --topic test-topic
kafka-topics.sh --delete --force --zookeeper 10.59.54.99:2181/kafka_dev --topic test-topic-1

## send massage

echo 'msg2' | kafka-console-producer.sh --broker-list localhost:9092 --topic test-topic-1
echo 'msg1' | kafka-console-producer.sh --broker-list 10.59.51.73:9092,10.59.51.51:9092 --topic test-topic-1


## consume messages

kafka-console-consumer.sh --zookeeper localhost:2181/kafka_v_0_10 --topic test-topic-1 --from-beginning
kafka-console-consumer.sh --zookeeper 10.59.54.99:2181/kafka_dev --topic test-topic-1 --from-beginning

## get topic offset info 

kafka-run-class.sh kafka.tools.GetOffsetShell --broker-list localhost:9092 --topic test-topic --offsets 10
kafka-run-class.sh kafka.tools.GetOffsetShell --broker-list 10.59.51.73:9092,10.59.51.51:9092 --topic test-topic-1 --offsets 10
```
