REPO=dmitryb/kafka-0.10.2.1
V=1.0

build:
	docker build -t $(REPO):$(V) .

push:
	docker push $(REPO):$(V)

clean:
	docker stop zookeeper && docker rm zookeeper
	docker stop kafka && docker rm kafka

run-servers:
	docker run -itd --name zookeeper -p 2181:2181 zookeeper
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

run-client:
	docker run -it --rm --hostname localhost --net=host dmitryb/kafka-0.10.2.1:1.0 bash
