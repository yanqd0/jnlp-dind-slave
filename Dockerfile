FROM jenkins/jnlp-slave:3.27-1

ARG DOCKER_VERSION=18.06.1~ce~3-0~debian
ARG DC_VERSION=1.23.2

USER root

RUN apt-get update \
    && apt-get install -qq -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && apt-key fingerprint 0EBFCD88 \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" \
    && apt-get update \
    && apt-get install -qq -y --no-install-recommends docker-ce=${DOCKER_VERSION} \
    && curl -L https://github.com/docker/compose/releases/download/${DC_VERSION}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
