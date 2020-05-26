#!/bin/bash
#
# Run the image to develop with Qt Creator
#

set -e

IMAGE_TAG=qtdevel
WORKING_DIR="${1:-$PWD}"
CONTAINER_NAME=
RUN_ARGS=

if [ -n "$CONTAINER_NAME" ]; then
    RUN_ARGS="$RUN_ARGS --name $CONTAINER_NAME"
fi

if [ "$1" == "shell" ]; then
    RUN_ARGS="$RUN_ARGS --entrypoint /bin/bash"
fi

podman run \
    --interactive \
    --tty \
    --volume "$WORKING_DIR":/root/workspace \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --device /dev/dri \
    --env DISPLAY=$DISPLAY \
    $RUN_ARGS \
    $IMAGE_TAG
