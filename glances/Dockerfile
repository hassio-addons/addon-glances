ARG BUILD_FROM=hassioaddons/base:4.0.1
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Copy Python requirements file
COPY requirements.txt /tmp/

# Setup base
ARG BUILD_ARCH=amd64
RUN \
    apk add --no-cache --virtual .build-dependencies \
        automake=1.16.1-r0 \
        gcc=8.3.0-r0 \
        linux-headers=4.19.36-r0 \
        musl-dev=1.1.22-r2 \
        python3-dev=3.7.3-r0 \
    \
    && apk add --no-cache \
        lua-resty-http=0.13-r0 \
        nginx-mod-http-lua=1.16.0-r2 \
        nginx=1.16.0-r2 \
        python3=3.7.3-r0 \
    \
    && pip3 install \
        --no-cache-dir \
        --prefer-binary \
        --find-links "https://wheels.hass.io/alpine-3.10/${BUILD_ARCH}/" \
        -r /tmp/requirements.txt \
    \
    && find /usr/local \
        \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' + \
    \
    && apk del --purge .build-dependencies \
    && rm -f -r /etc/nginx

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Glances" \
    io.hass.description="A cross-platform system monitoring tool" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Franck Nijhof <frenck@addons.community>" \
    org.label-schema.description="A cross-platform system monitoring tool" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Glances" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://community.home-assistant.io/t/community-hass-io-add-on-glances/97102?u=frenck" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-glances/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-glances" \
    org.label-schema.vendor="Community Hass.io Add-ons"
