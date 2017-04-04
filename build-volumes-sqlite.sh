#!/usr/bin/env bash

set -a
set -e
set -u

. ./env-vars.sh
. ./bash.bashrc.local

# Create volume container for data
docker create -v ${MASAR_SQLITE_DATA_DIR} --name ${MASAR_SERVICE_DOCKER_DATA_VOLUME} \
    --net ${NET_NAME} --dns ${DNS_IP} ${EPICS_DEV_DOCKER_ORG_NAME}/${EPICS_DEV_DOCKER_IMAGE_NAME} \
    2>/dev/null || true

# Create volume container for config
docker create -v ${MASAR_SQLITE_CONFIG_DIR} --name ${MASAR_SERVICE_DOCKER_CONFIG_VOLUME} \
    --net ${NET_NAME} --dns ${DNS_IP} ${EPICS_DEV_DOCKER_ORG_NAME}/${EPICS_DEV_DOCKER_IMAGE_NAME} \
    2>/dev/null || true
