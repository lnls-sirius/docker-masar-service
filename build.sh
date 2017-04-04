#!/usr/bin/env bash

. ./env-vars.sh

docker build -t ${MASAR_SERVICE_DOCKER_ORG_NAME}/${MASAR_SERVICE_DOCKER_IMAGE_NAME} .
