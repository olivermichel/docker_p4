
all: ubuntu_base ubuntu_protobuf_grpc

ubuntu_base: ubuntu_base.dockerfile
	docker build --tag $@ --file $< .

ubuntu_protobuf_grpc: ubuntu_protobuf_grpc.dockerfile ubuntu_base
	docker build --tag $@ --file $< .

.PHONY: ubuntu_base ubuntu_protobuf_grpc
