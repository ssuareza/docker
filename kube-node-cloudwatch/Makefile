VERSION ?= dev

.PHONY: help build test clean stop lint

help: ## Prints this help.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'

build:
	docker build -t ssuareza/kube-node-cloudwatch:${VERSION} .

push:
	docker push ssuareza/kube-node-cloudwatch:${VERSION}
