REPO=dmitryb/slack-cli
V=latest

build:
	docker build -t $(REPO):$(V) .

push:
	docker push $(REPO):$(V)

send-message:
	docker run -it -e SLACK_CLI_TOKEN=${SLACK_CLI_TOKEN} dmitryb/slack-cli:latest sh -c "/send-message.sh -d ${SLACK_USER} 'worflow finished; status: SUCCESS'"
