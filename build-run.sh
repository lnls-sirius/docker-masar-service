#!/usr/bin/env bash

set -a
set -e
set -u

# Source env vars
. ./env-vars.sh

# Build image
./build.sh

# Create docker network
./create-net.sh ${NET_NAME}

# Create volumes if not created
./build-volumes-sqlite.sh

# Run masar
./run.sh
