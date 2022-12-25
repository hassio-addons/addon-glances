#!/usr/bin/env bashio
# ==============================================================================
# Home Assistant Community Add-on: Glances
# Configures Glances
# ==============================================================================
declare header protocol
bashio::require.unprotected

# Ensure the configuration exists
if bashio::fs.file_exists '/config/glances/glances.conf'; then
    cp -f /config/glances/glances.conf /etc/glances.conf
else
    mkdir -p /config/glances \
        || bashio::exit.nok "Failed to create the Glances configuration directory"

    # Copy in template file
    cp /etc/glances.conf /config/glances/
fi

# Export Glances data to InfluxDB
if bashio::config.true 'influxdb.enabled'; then
    protocol='http'
    if bashio::config.true 'influxdb.ssl'; then
    protocol='https'
    fi

    header='influxdb'
    if bashio::config.equals 'influxdb.version' '2'; then
    header='influxdb2'
    fi

    # Modify the configuration
    {
        echo "[${header}]"
        echo "protocol=${protocol}"
        echo "host=$(bashio::config 'influxdb.host')"
        echo "port=$(bashio::config 'influxdb.port')"
        echo "prefix=$(bashio::config 'influxdb.prefix')"
    } >> /etc/glances.conf

    if bashio::config.equals 'influxdb.version' '1'; then
        {
            echo "user=$(bashio::config 'influxdb.username')"
            echo "password=$(bashio::config 'influxdb.password')"
            echo "db=$(bashio::config 'influxdb.database')"
        } >> /etc/glances.conf
    elif bashio::config.equals 'influxdb.version' '2'; then
        {
            echo "org=$(bashio::config 'influxdb.organization')"
            echo "bucket=$(bashio::config 'influxdb.bucket')"
            echo "token=$(bashio::config 'influxdb.token')"
        } >> /etc/glances.conf
    fi
fi
