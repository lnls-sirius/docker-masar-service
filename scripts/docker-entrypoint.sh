#!/usr/bin/env bash

set -a
set -e

# Source environment variables
. /build/bash.bashrc.local

MASAR_SQLITE_CONFIG_FILE=${MASAR_SQLITE_CONFIG_DIR}/db_config.txt
# Run MASAR config tool using a default db_config.txt
# if the final db_config.txt is not present
if [ ! -f ${MASAR_SQLITE_CONFIG_DIR}/db_config.txt ]; then
    echo "${MASAR_SQLITE_CONFIG_DIR}/db_config.txt file not found! Using defaults"
    # Using default one
    MASAR_SQLITE_CONFIG_FILE=${MASAR_SERVICE}/db_config.txt
fi

/build/masarService/masarConfigTool ${MASAR_SQLITE_CONFIG_FILE}

# execute other arguments wait-for-it script to wait for DB
exec "$@"
