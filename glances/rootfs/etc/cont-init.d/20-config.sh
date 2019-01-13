#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Glances
# Ensure the configuration exists
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

if hass.file_exists '/config/glances/glances.conf'; then
    cp -f /config/glances/glances.conf /etc/glances.conf
    exit "${EX_OK}"
fi

# Ensure configuration exists
mkdir -p /config/glances \
    || hass.die "Failed to create the Glances configuration directory"

# Copy in template file
cp /etc/glances.conf /config/glances/
