#!/usr/bin/env bash

#
# Build and push the images.
#
# Usage: build-push-images.sh mydockerhubuser/myreponame
# E.g. build-push-images.sh eugenesia/phpfarm
#
# Turn on Docker experimental mode to enable the --squash functionality.
# See https://github.com/docker/docker/tree/master/experimental
#

# Get the Docker hub user/repo so we know how to tag the built images and push
# them to Docker hub.
if [ -z "$1" ]; then
  hubUserRepo='cboulanger/docker-phpfarm'
else
  hubUserRepo="$1"
fi

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

echo "Pushing the image to the docker hub..."
docker push ${hubUserRepo}:latest

echo "Done."
