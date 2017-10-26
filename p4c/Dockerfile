
FROM ubuntu:16.04

ARG MAKEFLAGS
ENV MAKEFLAGS ${MAKEFLAGS:--j2}

ENV PROTOBUF_VERSION 3.2.0
ENV P4C_REVISION 3ad8d93

ENV PROTOBUF_DEPS autoconf automake g++ libtool make curl unzip

ENV P4C_DEPS bison build-essential cmake flex g++ libboost-dev libboost-graph-dev \
  libboost-iostreams1.58-dev libfl-dev libgc-dev libgmp-dev pkg-config python-ipaddr \
  python-pip python-setuptools tcpdump

ENV P4C_RUNTIME_DEPS cpp libboost-graph1.58.0 libboost-iostreams1.58.0 libgc1c2 \
  libgmp10 libgmpxx4ldbl python

RUN apt-get update && apt-get install -y --no-install-recommends git ca-certificates

WORKDIR /root/opt
RUN git clone https://github.com/google/protobuf.git

WORKDIR /root/opt/protobuf
RUN git checkout tags/v$PROTOBUF_VERSION && \
  apt-get update && apt-get install -y --no-install-recommends $PROTOBUF_DEPS && \
  export LDFLAGS="-Wl,-s" && \
  ./autogen.sh && ./configure && \
  make && make install && ldconfig

RUN mkdir -p /root/opt
WORKDIR /root/opt
RUN apt-get update && apt-get install -y --no-install-recommends git $P4C_DEPS $P4C_RUNTIME_DEPS \
  && pip install tenjin

RUN git clone https://github.com/p4lang/p4c p4c
WORKDIR /root/opt/p4c
RUN git checkout $P4C_REVISION && git submodule update --init --recursive

RUN mkdir build && cd build && cmake .. '-DCMAKE_CXX_FLAGS:STRING=-O3' && \
    make && make install && ldconfig
