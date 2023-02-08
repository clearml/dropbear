#!/bin/bash

docker build -t dropbearbuild -f Dockerfile .

docker run --rm -t -v $(pwd):/root/dropbear dropbearbuild -c "./configure --disable-zlib --disable-syslog --enable-static --disable-harden && make PROGRAMS=\"dropbear dropbearconvert\""

docker image rm dropbearbuild
