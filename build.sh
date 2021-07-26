#!/usr/bin/env bash

#
# Build the image.
#
REPO='cboulanger/docker-phpfarm'

echo
echo "Building PHPFarm Docker image '${REPO}'"
echo "This will take a while. You can follow the output with tail -f ./build.log "

docker build --progress plain -t ${REPO}:latest -t \
  ${REPO}:latest .  2>&1 \
  | tee ./build.log \
  | grep -o ">>> [^\"]*$"

retval_bash="${PIPESTATUS[0]}" retval_zsh="${pipestatus[1]}"
retval=$retval_bash $retval_zsh
if [ $retval != 0 ]; then
    echo "Build failed with an error:"
    tail -n 50 ./build.log
    exit 1
fi

./test.sh

echo "Done."
