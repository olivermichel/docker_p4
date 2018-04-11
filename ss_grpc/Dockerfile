
FROM ubuntu_protobuf_grpc:latest

# Mar 16, 2018
ENV BM_REVISION 1be2133

# Apr 6, 2018
ENV PI_REVISION 456970f

# Apr 9, 2018
ENV P4C_REVISION 6d265b2

# build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends automake \
  build-essential libjudy-dev libgmp-dev libpcap-dev \
  libboost-dev libboost-program-options-dev libboost-system-dev \
  libboost-filesystem-dev libboost-thread-dev libtool pkg-config

# pi
RUN cd /root/opt && \
  git clone https://github.com/p4lang/PI pi && \
  cd /root/opt/pi && \
  git checkout $PI_REVISION && git submodule update --init --recursive && \
  export CFLAGS="-O0" && export CXXFLAGS="-O0" && \
  ./autogen.sh && ./configure --with-proto --without-cli --without-internal-rpc && \
  make && make install && ldconfig

# bm
RUN cd /root/opt && \
  git clone https://github.com/p4lang/behavioral-model.git bm && \
  cd /root/opt/bm && \
  git checkout $BM_REVISION && \
  export CFLAGS="-O0" && export CXXFLAGS="-O0" && \
  ./autogen.sh && ./configure --without-thrift --without-nanomsg --with-pi && \
  make && make install && ldconfig

# grpc simple switch target
RUN cd /root/opt/bm/targets/simple_switch_grpc && \
  export CFLAGS="-O0" && export CXXFLAGS="-O0" && \
  ./autogen.sh && ./configure && make
