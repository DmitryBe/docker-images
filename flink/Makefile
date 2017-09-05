REPO=localhost:5000/flink
TAG=latest

docker-build:
	docker build -t $(REPO):$(TAG) .

docker-push:
	docker push $(REPO):$(TAG)

