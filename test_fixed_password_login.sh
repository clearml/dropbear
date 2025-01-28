#!/bin/bash

echo "Testing ./build/dropbear"
echo "------------------------"

PASSWORD=pa55w0rD
echo "TEST PASSWORD FOR ANY USER $PASSWORD"

docker run --rm -p 10022:10022 -v $(pwd)/build:/root/dropbear ubuntu:24.04 bash -c "/root/dropbear/dropbearmulti dropbearkey -t ed25519 -f dropbear_ed25519_host_key && mkdir -p /etc/dropbear && cp dropbear_ed25519_host_key* /etc/dropbear/ && DROPBEAR_CLEARML_FIXED_PASSWORD=$PASSWORD /root/dropbear/dropbearmulti dropbear -e -K 30 -I 0 -F -p 10022" &

echo "wait for docker 5 sec..."

sleep 5

echo "Login with password: $PASSWORD"

ssh user@localhost -o UserKnownHostsFile=/dev/null -p 10022

kill %1
