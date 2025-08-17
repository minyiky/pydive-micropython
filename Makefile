.PHONY: run docker-build

SHELL := /bin/bash
VERSION:=0.5.0
LATEST_TAG = $(eval LATEST_TAG := $(shell \
    git ls-remote --tags origin \
    | awk -F/ '{print $$3}' \
    | sort -V \
    | tail -n 1))$(LATEST_TAG)

docker-build:
	@docker build -t micropython .

version:
	@echo $(VERSION)

check-version-update:
	@if [ "$(VERSION)" = "$(LATEST_TAG)" ] || [ "$(VERSION)" != "$$(echo -e "$(LATEST_TAG)\n$(VERSION)" | sort -V | tail -n 1)" ]; then echo "Version $(VERSION) has not been updated"; exit 1; fi

run:
	@docker run -it --rm -e DISPLAY=$(DISPLAY) -v /tmp/.X11-unix:/tmp/.X11-unix:ro micropython

run-with-file:
	@docker run -it --rm -e DISPLAY=$(DISPLAY) -v /tmp/.X11-unix:/tmp/.X11-unix:ro -v $$(pwd)/$(FILE):/$(FILE) micropython /$(FILE)
