#/bin/bash
PLUGINS ?= ceph
HELM_HOME ?= $(helm home)

.PHONY: install

all: ceph

install:
	cp -av helm-plugins/$(PLUGINS) $(HELM_HOME)/plugins

build-%:
	cd helm-charts; if [ -f $*/Makefile ]; then make -C $*; fi
	cd helm-charts; if [ -f $*/requirements.yaml ]; then helm dep up $*; fi
	cd helm-charts; helm package $*

gantry-%:
	docker build dockerfiles/helm-plugins/$* -t docker.io/gantry/$*:latest
