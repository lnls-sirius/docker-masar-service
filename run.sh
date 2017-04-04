#!/usr/bin/env bash

set -a
set -e
set -u

. ./env-vars.sh

# Run Masar
docker run -d --name ${MASAR_SERVICE_DOCKER_RUN_NAME} --net ${NET_NAME} --dns ${DNS_IP} \
    --volumes-from ${MASAR_SERVICE_DOCKER_DATA_VOLUME} --volumes-from ${MASAR_SERVICE_DOCKER_CONFIG_VOLUME} \
    ${MASAR_SERVICE_DOCKER_ORG_NAME}/${MASAR_SERVICE_DOCKER_IMAGE_NAME}
