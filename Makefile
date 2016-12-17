#/bin/bash
PLUGINS ?= ceph
HELM_HOME ?= $(helm home)

.PHONY: install

all: install

install:
	cp -av helm-plugins/$(PLUGINS) /home/harbor/.helm/plugins


build-dkr-helm-%:
	docker build dockerfiles/helm-plugins/$* -t docker.io/gantry/$*:latest

build-dind-%:
	docker build dockerfiles/dind/$* -t docker.io/jetty/$*:latest


build-%:
	cd helm-charts; if [ -f $*/Makefile ]; then make -C $*; fi
	cd helm-charts; if [ -f $*/requirements.yaml ]; then helm dep up $*; fi
	cd helm-charts; helm package $*
