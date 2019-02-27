ARG BUILD_FROM=hassioaddons/base:2.3.2
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Copy Python requirements file
COPY requirements.txt /tmp/

# Setup base
RUN \
    apk add --no-cache --virtual .build-dependencies \
        automake=1.16.1-r0 \
        gcc=6.4.0-r9 \
        linux-headers=4.4.6-r2 \
        musl-dev=1.1.19-r10 \
        python3-dev=3.6.6-r0 \
    \
    && apk add --no-cache \
        lua-resty-http=0.12-r1 \
        nginx-mod-http-lua=1.14.2-r0 \
        nginx=1.14.2-r0 \
        py3-bottle=0.12.13-r2 \
        py3-psutil=5.4.6-r0 \
        python3=3.6.6-r0 \
    \
    && pip3 install --no-cache-dir -r /tmp/requirements.txt \
    \
    && apk del --purge .build-dependencies

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
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
