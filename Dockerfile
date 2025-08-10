FROM alpine:3.22.1 AS builder

RUN apk add --no-cache alpine-sdk
RUN apk add --no-cache \
    musl-dev \
    zlib-dev \
    tar \
    bzip2 \
    bash

COPY . /root/dropbear/

WORKDIR /root/dropbear/

RUN ./configure --disable-utmp --disable-wtmp --disable-lastlog --disable-zlib --disable-syslog --enable-static --disable-harden && make clean && make -j4 MULTI=1 PROGRAMS="dropbear dropbearconvert dropbearkey" && mv dropbearmulti dropbearmulti_ && make clean && mv dropbearmulti_ dropbearmulti && strip dropbearmulti
RUN mkdir -p /tmp/dropbear/ && cp dropbearmulti /tmp/dropbear/

# export stage
FROM scratch AS export-stage
COPY --from=builder /tmp/dropbear/dropbearmulti /dropbearmulti
