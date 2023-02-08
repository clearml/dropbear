FROM alpine:3.17.1 AS builder

RUN apk add --no-cache alpine-sdk
RUN apk add --no-cache \
    musl-dev \
    zlib-dev \
    tar \
    bzip2 \
    bash

RUN mkdir -p /root/dropbear/
WORKDIR /root/dropbear/

ENTRYPOINT ["bash"]
