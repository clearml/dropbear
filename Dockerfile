FROM ubuntu:22.04

ENV LC_ALL=C.UTF-8

RUN apt-get update

RUN apt-get install -y build-essential git autoconf

RUN mkdir -p /root/dropbear/
WORKDIR /root/dropbear/

# ./configure --disable-zlib --disable-syslog --enable-static --disable-harden
# make PROGRAMS="dropbear dropbearconvert"

ENTRYPOINT ["bash"]
