#!/usr/bin/env bash

#
# Build the image.
#
hubUserRepo='cboulanger/docker-phpfarm'

echo
echo "Building PHPFarm Docker image '${hubUserRepo}' for Debian Jessie"
echo "This will take a while. You can follow the output with tail -f ./build.log "

docker build --squash --no-cache -t ${hubUserRepo}:jessie -t \
  ${hubUserRepo}:latest -f Dockerfile-Jessie .  2>&1 \
  | tee ./build.log \
  | grep ^">>> "

retval_bash="${PIPESTATUS[0]}" retval_zsh="${pipestatus[1]}"
retval=$retval_bash $retval_zsh
if [ $retval != 0 ]; then
    echo "Build failed with an error:"
    tail -n 50 ./build.log
    exit 1
fi

echo "Done."
