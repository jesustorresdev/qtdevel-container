#!/bin/bash
#
# Build a image to develop with Qt Creator
#

set -e

IMAGE_TAG=qtdevel
BUILD_ARGS=

if [ "$(uname -m)" == "x86" ]; then
    BUILD_ARGS="$BUILD_ARGS --build-arg CPU_ARCHITECTURE=x86"
fi

if [ -e /etc/timezone ]; then
    BUILD_ARGS="$BUILD_ARGS --build-arg TZ=$(cat /etc/timezone)"
fi

podman build \
    --tag $IMAGE_TAG \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --device /dev/dri \
    --build-arg DISPLAY=$DISPLAY \
    $BUILD_ARGS .
