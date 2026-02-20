# although we could use any path inside docker, using the same path as on the host
# allows the DWARF info (when building in DEBUG) to contain the correct file paths
DOCKER_WORKSPACE=$(pwd)

mkdir -p "${DOCKER_WORKSPACE}/dist"

docker run $@ \
  --rm \
  -e DEBUG=${DEBUG:-false} \
  --workdir=${DOCKER_WORKSPACE} \
  -v ${DOCKER_WORKSPACE}:${DOCKER_WORKSPACE}:rw \
  -v ${DOCKER_WORKSPACE}/dist:/install/pglite:rw \
  electricsql/pglite-builder:3.1.74_4 \
  ./build-pglite.sh
  
