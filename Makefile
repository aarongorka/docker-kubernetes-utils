KUBECTL_VERSION = 1.8.4
IMAGE_NAME ?= aarongorka/kubernetes-utils:$(KUBECTL_VERSION)

dockerBuild:
	docker build -t $(IMAGE_NAME) .

pull:
	docker pull $(IMAGE_NAME)

shell:
	docker run --rm -it -v $(PWD):/opt/app:Z -w /opt/app $(IMAGE_NAME) sh

tag:
	-git tag -d $(KUBECTL_VERSION)
	-git push origin :refs/tags/$(KUBECTL_VERSION)
	git tag $(KUBECTL_VERSION)
	git push origin $(KUBECTL_VERSION)

