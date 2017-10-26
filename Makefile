
DOCKER=docker

all: deps p4c ss_grpc

deps:
	$(MAKE) -C deps

p4c: p4c/Dockerfile
	$(DOCKER) build --tag $@ --memory=8g --file $< $@

ss_grpc: ss_grpc/Dockerfile
	$(DOCKER) build --tag $@ --memory=4g --file $< $@

clean:
	$(RM) ss_grpc.cid

.PHONY: p4c ss_grpc clean deps
