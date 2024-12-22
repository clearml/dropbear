#!/bin/bash

docker build -t dropbearbuild -f Dockerfile .

docker run --rm -t -v $(pwd):/root/dropbear dropbearbuild -c "./configure --disable-utmp --disable-wtmp --disable-lastlog --disable-zlib --disable-syslog --enable-static --disable-harden && make clean && make -j4 MULTI=1 PROGRAMS=\"dropbear dropbearconvert dropbearkey\" && mv dropbearmulti dropbearmulti_ && make clean && mv dropbearmulti_ dropbearmulti"

docker image rm dropbearbuild
