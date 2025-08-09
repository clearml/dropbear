#!/bin/bash

platform=${platform:-linux/amd64}
docker build -t dropbearbuild --platform $platform -f Dockerfile .

docker run --rm --platform $platform -t -v $(pwd):/root/dropbear dropbearbuild -c "./configure --disable-utmp --disable-wtmp --disable-lastlog --disable-zlib --disable-syslog --enable-static --disable-harden && make clean && make -j4 MULTI=1 PROGRAMS=\"dropbear dropbearconvert dropbearkey\" && mv dropbearmulti dropbearmulti_ && make clean && mv dropbearmulti_ dropbearmulti && strip dropbearmulti"

docker image rm dropbearbuild

mkdir -p build/$platform
cp dropbearmulti ./build/$platform/
