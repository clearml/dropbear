#!/bin/bash

echo "Testing ./build/dropbear"
echo "------------------------"

PASSWORD=pa55w0rD
echo "TEST PASSWORD FOR ANY USER $PASSWORD"

platform=${platform:-linux/amd64}

echo platform=$platform
docker run --rm --platform $platform --user 1000 -p 10022:10022 -v $(pwd)/build/$platform:/dropbear ubuntu:24.04 bash -c "/dropbear/dropbearmulti dropbearkey -t ed25519 -f /tmp/dropbear_ed25519_host_key && DROPBEAR_CLEARML_FIXED_PASSWORD=$PASSWORD /dropbear/dropbearmulti dropbear -e -K 30 -I 0 -F -p 10022 -r /tmp/dropbear_ed25519_host_key" &

echo "wait for docker 5 sec..."

sleep 5

echo "Login with password: $PASSWORD"

ssh user@localhost -o UserKnownHostsFile=/dev/null -p 10022

kill %1
