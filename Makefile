
DOCKER=docker

all: p4c ss_grpc

p4c/Dockerfile:
	git clone --recursive https://github.com/p4lang/p4c.git p4c

p4c: p4c/Dockerfile
	$(DOCKER) build --tag $@ --memory=4g --file $< $@

ss_grpc: ss_grpc/Dockerfile
	$(DOCKER) build --tag $@ --memory=4g --file $< $@

clean:
	$(RM) ss_grpc.cid

.PHONY: p4c ss_grpc clean
