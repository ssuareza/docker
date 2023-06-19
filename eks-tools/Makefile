.PHONY: build push

VERSION ?= dev
IMAGE_NAME := "ssuareza/eks-tools"

build:
	@docker build --no-cache -t $(IMAGE_NAME):${VERSION} -t $(IMAGE_NAME):latest .

push:
	@docker push $(IMAGE_NAME):${VERSION}