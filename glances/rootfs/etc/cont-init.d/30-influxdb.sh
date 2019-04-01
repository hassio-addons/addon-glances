#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: Glances
# Export Glances data to InfluxDB
# ==============================================================================
if bashio::config.false 'influxdb.enabled'; then
    exit "${EX_OK}"
fi

# Modify the configuration
{
    echo "[influxdb]"
    echo "host=$(bashio::config 'influxdb.host')"
    echo "port=$(bashio::config 'influxdb.port')"
    echo "user=$(bashio::config 'influxdb.username')"
    echo "password=$(bashio::config 'influxdb.password')"
    echo "db=$(bashio::config 'influxdb.database')"
    echo "prefix=$(bashio::config 'influxdb.prefix')"
} >> /etc/glances.conf
