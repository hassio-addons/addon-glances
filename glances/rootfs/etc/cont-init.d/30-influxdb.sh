#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Glances
# Export Glances data to InfluxDB
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

if hass.config.false 'influxdb.enabled'; then
    exit "${EX_OK}"
fi

# Modify the configuration
{
    echo "[influxdb]"
    echo "host=$(hass.config.get 'influxdb.host')"
    echo "port=$(hass.config.get 'influxdb.port')"
    echo "user=$(hass.config.get 'influxdb.username')"
    echo "password=$(hass.config.get 'influxdb.password')"
    echo "prefix=$(hass.config.get 'influxdb.prefix')"
    echo "db=$(hass.config.get 'influxdb.database')"
} >> /etc/glances.conf
