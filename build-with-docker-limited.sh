#!/bin/bash
# Build script with limited parallelism for memory-constrained environments (Podman)
# Uses a modified build script with explicit -j2 to prevent OOM kills

DOCKER_WORKSPACE=/workspace

docker run "$@" \
  --rm \
  -e DEBUG=${DEBUG:-false} \
  -e JOBS=${JOBS:-2} \
  --workdir=${DOCKER_WORKSPACE} \
  -v "$(pwd):${DOCKER_WORKSPACE}:rw" \
  -v "$(pwd)/dist:/install/pglite:rw" \
  electricsql/pglite-builder:3.1.74_4 \
  ./build-pglite-limited.sh
