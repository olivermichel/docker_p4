
FROM ubuntu_protobuf_grpc:latest

ENV BM_DEPS automake build-essential libjudy-dev libgmp-dev libpcap-dev \
  libboost-dev libboost-program-options-dev libboost-system-dev \
  libboost-filesystem-dev libboost-thread-dev libtool pkg-config

ENV BM_REVISION ae84c2f
ENV PI_REVISION 624f9c4
ENV P4C_REVISION 3ad8d93

WORKDIR /root/opt
RUN apt-get update && apt-get install -y --no-install-recommends $BM_DEPS
RUN git clone https://github.com/p4lang/PI pi

WORKDIR /root/opt/pi
RUN git checkout $PI_REVISION && git submodule update --init --recursive && \
  export CFLAGS="-O0" && export CXXFLAGS="-O0" && \
  ./autogen.sh && ./configure --with-proto --without-cli --without-internal-rpc && \
  make && make install && ldconfig

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
