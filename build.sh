#!/bin/bash

platform=${platform:-linux/amd64}

docker build -f Dockerfile --platform $platform --progress=plain --output type=tar,dest=dropbear_musl.tar .

mkdir -p build/$platform
tar -xf dropbear_musl.tar -C ./build/$platform/
rm dropbear_musl.tar
