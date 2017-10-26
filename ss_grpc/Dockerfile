
FROM ubuntu:16.04

ARG MAKEFLAGS
ENV MAKEFLAGS ${MAKEFLAGS:--j4}

ENV PROTOBUF_DEPS autoconf automake g++ libtool make curl unzip
ENV GRPC_DEPS build-essential autoconf libtool
ENV BM_DEPS automake build-essential libjudy-dev libgmp-dev libpcap-dev \
  libboost-dev libboost-program-options-dev libboost-system-dev \
  libboost-filesystem-dev libboost-thread-dev libtool pkg-config

ENV GRPC_VERSION 1.3.2
ENV PROTOBUF_VERSION 3.2.0
ENV BM_REVISION ae84c2f
ENV PI_REVISION 624f9c4
ENV P4C_REVISION 3ad8d93

RUN mkdir -p /root/opt
RUN mkdir -p /root/src
RUN apt-get update && apt-get install -y --no-install-recommends git ca-certificates

WORKDIR /root/opt
RUN git clone https://github.com/google/protobuf.git

WORKDIR /root/opt/protobuf
RUN git checkout tags/v$PROTOBUF_VERSION && \
  apt-get update && apt-get install -y --no-install-recommends $PROTOBUF_DEPS && \
  export LDFLAGS="-Wl,-s" && \
  ./autogen.sh && ./configure && \
  make && make install && ldconfig

  # apt-get purge -y $PROTOBUF_DEPS && apt-get autoremove --purge -y && \
  # rm -rf /protobuf /var/cache/apt/* /var/lib/apt/lists/* /var/cache/debconf/* /var/lib/dpkg/*-old /var/log/*

WORKDIR /root/opt
RUN git clone https://github.com/google/grpc.git

WORKDIR /root/opt/grpc
RUN git checkout tags/v$GRPC_VERSION && git submodule update --init --recursive && \
  apt-get update && apt-get install -y --no-install-recommends $GRPC_DEPS libgflags-dev && \
  export LDFLAGS="-Wl,-s" && \
  make && make grpc_cli && make install && ldconfig

  # cp /grpc/bins/opt/grpc_cli /usr/bin/ && \
  # apt-get purge -y $GRPC_DEPS && apt-get autoremove --purge -y && \
  # rm -rf /grpc /var/cache/apt/* /var/lib/apt/lists/* /var/cache/debconf/* /var/lib/dpkg/*-old /var/log/*

WORKDIR /root/opt
RUN apt-get update && apt-get install -y --no-install-recommends $BM_DEPS
RUN git clone https://github.com/p4lang/PI pi

WORKDIR /root/opt/pi
RUN git checkout $PI_REVISION && git submodule update --init --recursive && \
  export CFLAGS="-O0" && export CXXFLAGS="-O0" && \
  ./autogen.sh && ./configure --with-proto --without-cli --without-internal-rpc && \
  make && make install && ldconfig

  #  && \
  # rm -rf /PI/

WORKDIR /root/opt
RUN git clone https://github.com/p4lang/behavioral-model.git bm

WORKDIR /root/opt/bm
RUN git checkout $BM_REVISION && \
  export CFLAGS="-O0" && export CXXFLAGS="-O0" && \
  ./autogen.sh && ./configure --without-thrift --without-nanomsg --with-pi && \
  make && make install && ldconfig

WORKDIR /root/opt/bm/targets/simple_switch_grpc
RUN export CFLAGS="-O0" && export CXXFLAGS="-O0" && \
  ./autogen.sh && ./configure && make
