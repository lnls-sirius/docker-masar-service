# Masar server with additional configurations

FROM lnls/docker-epics-dev

MAINTAINER Lucas Russo

# User root user to install software
USER root

# Install missing dependencies
RUN echo nameserver 10.0.0.71 >> /etc/resolv.conf && \
        apt-get update && apt-get install -y \
        python2.7-dev \
        python-pip \
        sqlite3 \
        python-qt4 \
        python-pymongo \
    && rm -rf /var/lib/apt/lists/* \
    && pip install cothread

# Setup git, only for applying patches
RUN git config --global user.email "masar-service-docker@masar-service-docker.com"
RUN git config --global user.name "MASAR_SERVICE Docker"

# Create build directory
RUN mkdir -p /build

# Copy compilation scripts to build directory
COPY setup.sh \
        env-vars.sh \
        bash.bashrc.local \
        download-install-app.sh \
        /build/

# Change to build directory
WORKDIR /build

## Compile application
RUN echo nameserver 10.0.0.71 >> /etc/resolv.conf && \
    /build/setup.sh

# Create volume for SQLite configuration
VOLUME /var/lib/sqlite/config
# Create volume for SQLite data
VOLUME /var/lib/sqlite/data

# Change to root directory
WORKDIR /

# Run service
#CMD ["sh", "-c", "/build/masarService/masarConfigTool", "/var/lib/sqlite/config/db_config.txt", "&&", "/build/masarService/cpp/bin/linux-x86_64/masarServiceRun", "masarService"]
CMD sh -c /build/masarService/masarConfigTool /var/lib/sqlite/config/db_config.txt && /build/masarService/cpp/bin/linux-x86_64/masarServiceRun masarService
