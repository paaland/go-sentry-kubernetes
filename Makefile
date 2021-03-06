VERSION=$(shell git describe --always --long)
GOBUILD=go build .
DOCKER_USER=stevelacy
NAME=go-sentry-kubernetes
IMAGE=$(DOCKER_USER)/$(NAME):$(VERSION)
LATEST=$(DOCKER_USER)/$(NAME):latest

all: docker

build:
	$(GOBUILD)

build_linux:
	GOOS=linux GOARCH=386 CGO_ENABLED=0 $(GOBUILD)

docker:
	docker build -t $(IMAGE) .
	docker tag $(IMAGE) $(LATEST)

push:
	docker push $(IMAGE)
	docker push $(LATEST)

clean:
	rm -f $(NAME)
