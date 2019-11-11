NAME     := ride-locust
VERSION  := v0.0.1
REVISION := $(shell git rev-parse --short HEAD)
SRCS     := $(shell find . -type f -name '*.go')
LDFLAGS  := -ldflags="-s -w -X \"main.Version=$(VERSION)\" -X \"main.Revision=$(REVISION)\" -extldflags \"-static\""

.PHONY: dep
dep:
	go get -u golang.org/x/lint/golint

.PHONY: lint
lint:
	find . -name '*.go' -print |grep -v vendor |xargs golint

.PHONY: all
all: dep lint $(SRCS)
	GOOS=linux GOARCH=amd64 go build -a -tags netgo -installsuffix netgo $(LDFLAGS) -o bin/ride-locust main.go