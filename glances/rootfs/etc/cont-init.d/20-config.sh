#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: Glances
# Ensure the configuration exists
# ==============================================================================
if bashio::fs.file_exists '/config/glances/glances.conf'; then
    cp -f /config/glances/glances.conf /etc/glances.conf
    exit 0
fi

# Ensure configuration exists
mkdir -p /config/glances \
    || bashio::exit.nok "Failed to create the Glances configuration directory"

# Copy in template file
cp /etc/glances.conf /config/glances/
