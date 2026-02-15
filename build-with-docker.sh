# although we could use any path inside docker, using the same path as on the host
# allows the DWARF info (when building in DEBUG) to contain the correct file paths
DOCKER_WORKSPACE=$(pwd)
DIST_DIR="${DOCKER_WORKSPACE}/dist"
CONFIG_STATUS="${DOCKER_WORKSPACE}/config.status"

mkdir -p "${DIST_DIR}"

# If a previous build configured with a different in-container workspace (e.g. /work),
# stale paths can be cached in config.status / generated makefiles. Force reconfigure.
if [[ -f "${CONFIG_STATUS}" ]] && grep -q '/work/other/PGPASSFILE@/home/web_user/.pgpass' "${CONFIG_STATUS}"; then
  echo "build-with-docker.sh: detected stale /work embed path in config.status; removing config.status to force reconfigure."
  rm -f "${CONFIG_STATUS}"
fi

docker run "$@" \
  --rm \
  -e DEBUG=${DEBUG:-false} \
  --workdir=${DOCKER_WORKSPACE} \
  -v ${DOCKER_WORKSPACE}:${DOCKER_WORKSPACE}:rw \
  -v ${DIST_DIR}:/install/pglite:rw \
  electricsql/pglite-builder:3.1.74_4 \
  ./build-pglite.sh
