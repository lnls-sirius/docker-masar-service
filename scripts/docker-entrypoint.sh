#!/usr/bin/env bash

set -a
set -e

# Source environment variables
. /build/bash.bashrc.local

# Run MASAR config tool
/build/masarService/masarConfigTool /var/lib/sqlite/config/db_config.txt

# execute other arguments wait-for-it script to wait for DB
exec "$@"
