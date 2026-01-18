#!/bin/bash
# Clean script that runs inside the Docker container

DOCKER_WORKSPACE=/workspace

docker run "$@" \
  --rm \
  --workdir=${DOCKER_WORKSPACE} \
  -v "$(pwd):${DOCKER_WORKSPACE}:rw" \
  -v "$(pwd)/dist:/install/pglite:rw" \
  electricsql/pglite-builder:3.1.74_4 \
  ./clean-pglite.sh
