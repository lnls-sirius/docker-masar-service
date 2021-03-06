#!/usr/bin/env bash

set -a
set -e
set -u

. ./env-vars.sh

# Run Masar
docker run -d --name ${MASAR_SERVICE_DOCKER_RUN_NAME} --net ${NET_NAME} --dns ${DNS_IP} \
    --volumes-from ${MASAR_SERVICE_DOCKER_DATA_VOLUME} --volumes-from ${MASAR_SERVICE_DOCKER_CONFIG_VOLUME} \
    -p ${LOCAL_EPICS_SERVER_PORT}:${EPICS_SERVER_PORT}/tcp \
    -p ${LOCAL_EPICS_SERVER_PORT}:${EPICS_SERVER_PORT}/udp \
    -p ${LOCAL_EPICS_BEACON_PORT}:${EPICS_BEACON_PORT}/tcp \
    -p ${LOCAL_EPICS_BEACON_PORT}:${EPICS_BEACON_PORT}/udp \
    -p ${LOCAL_EPICS_V4_SERVER_PORT}:${EPICS_V4_SERVER_PORT}/tcp \
    -p ${LOCAL_EPICS_V4_SERVER_PORT}:${EPICS_V4_SERVER_PORT}/udp \
    -p ${LOCAL_EPICS_V4_BROADCAST_PORT}:${EPICS_V4_BROADCAST_PORT}/tcp \
    -p ${LOCAL_EPICS_V4_BROADCAST_PORT}:${EPICS_V4_BROADCAST_PORT}/udp \
    ${MASAR_SERVICE_DOCKER_ORG_NAME}/${MASAR_SERVICE_DOCKER_IMAGE_NAME}
