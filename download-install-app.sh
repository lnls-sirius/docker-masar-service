#!/usr/bin/env bash

set -e
set -u

# Source env vars
. ./env-vars.sh

# Source bashrc
. ./bash.bashrc.local

TOP_DIR=$(pwd)

# Clone LNLS EPICS installation scripts
git clone --branch=${MASAR_SERVICE_VERSION} https://github.com/epics-base/masarService \
    ${MASAR_SERVICE_REPO}

## Apply patches
#cd ${MASAR_SERVICE_REPO}
#git am --ignore-whitespace /build/patches/masar-service/*
#cd ..

# Append Masar environment variables to profile
sudo cat ${TOP_DIR}/bash.bashrc.local >> /etc/bash.bashrc

# Fix Masar RELEASE.local file
cd ${MASAR_SERVICE_REPO}

rm RELEASE.local.example

cat << 'EOF' > /build/${MASAR_SERVICE_REPO}/RELEASE.local
PYTHON=python2.7
PYTHON_BASE=/usr
${PYTHON}_DIR = ${PYTHON_BASE}/lib/${PYTHON}/config-x86_64-linux-gnu

EV4_BASE=/opt/epics/v4
PVACLIENT=${EV4_BASE}/pvaClientCPP
PVDATABASE=${EV4_BASE}/pvDatabaseCPP
PVASRV=${EV4_BASE}/pvaSrv
PVACCESS=${EV4_BASE}/pvAccessCPP
NORMATIVETYPES=${EV4_BASE}/normativeTypesCPP
PVDATA=${EV4_BASE}/pvDataCPP
PVCOMMON=${EV4_BASE}/pvCommonCPP
EPICS_BASE=/opt/epics/base
EOF

# Backend config
cat <<EOF > masarservice.conf
[Common]
database = sqlite
[sqlite]
database =${MASAR_SQLITE_DB}
EOF

cd ..

# Create directory for storing config/data files
mkdir -p ${MASAR_SQLITE_CONFIG_DIR} && chmod -R 777 ${MASAR_SQLITE_CONFIG_DIR}
mkdir -p ${MASAR_SQLITE_DATA_DIR} && chmod -R 777 ${MASAR_SQLITE_DATA_DIR}

# Build MASAR
cd ${MASAR_SERVICE_REPO}
make
cd ..
