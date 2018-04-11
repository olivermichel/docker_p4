
FROM ubuntu_base:latest

ENV GRPC_VERSION 1.3.2
ENV PROTOBUF_VERSION 3.2.0

ENV PROTOBUF_DEPS autoconf automake g++ libtool make curl unzip
ENV GRPC_DEPS build-essential autoconf libtool

WORKDIR /root/opt
RUN git clone https://github.com/google/protobuf.git

WORKDIR /root/opt/protobuf
RUN git checkout tags/v$PROTOBUF_VERSION && \
  apt-get update && apt-get install -y --no-install-recommends $PROTOBUF_DEPS && \
  export LDFLAGS="-Wl,-s" && \
  ./autogen.sh && ./configure && \
  make && make install && ldconfig

WORKDIR /root/opt
RUN git clone https://github.com/google/grpc.git

WORKDIR /root/opt/grpc
RUN git checkout tags/v$GRPC_VERSION && git submodule update --init --recursive && \
  apt-get update && apt-get install -y --no-install-recommends $GRPC_DEPS libgflags-dev && \
  export LDFLAGS="-Wl,-s" && \
  make && make grpc_cli && make install && ldconfig
