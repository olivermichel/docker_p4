
FROM ubuntu:16.04

MAINTAINER Oliver Michel <oliver.michel@editum.de>

ARG MAKEFLAGS
ENV MAKEFLAGS ${MAKEFLAGS:--j4}
ENV PKG git ca-certificates build-essential bash

RUN mkdir -p /root/opt /root/src /root/mnt
RUN apt-get update && apt-get install -y --no-install-recommends git ca-certificates
WORKDIR /root
RUN git clone https://github.com/olivermichel/dotfiles.git .dotfiles

RUN echo ". ~/.dotfiles/sh/common.sh\n \
          . ~/.dotfiles/sh/linux.sh\n  \
          . ~/.dotfiles/sh/bash/config.bash\n \
          . ~/.dotfiles/sh/bash/prompt-min.bash" > .bashrc
