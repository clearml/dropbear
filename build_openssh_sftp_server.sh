#!/bin/bash

OPENSSH_SFTP_VER="${OPENSSH_SFTP_VER:-V_10_0_P2}"

DROPBEAR_OUT_DIR="${1:-./build}"

platform="${platform:-linux/amd64}"

mkdir -p $DROPBEAR_OUT_DIR/$platform


# openssh sftp build
docker build -f openssh_sftp_server_build_static.Dockerfile --build-arg OPENSSH_SFTP_VER=$OPENSSH_SFTP_VER --platform $platform --progress=plain --output type=tar,dest=sftpbin_musl.tar .
tar -xf sftpbin_musl.tar -C $DROPBEAR_OUT_DIR/$platform
rm sftpbin_musl.tar
