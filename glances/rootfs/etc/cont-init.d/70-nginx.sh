#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: Glances
# Configure the use of SSL in NGINX
# ==============================================================================
if bashio::config.true 'ssl'; then
    certfile=$(bashio::config 'certfile')
    keyfile=$(bashio::config 'keyfile')

    sed -i "s/%%certfile%%/${certfile}/g" /etc/nginx/nginx-ssl.conf
    sed -i "s/%%keyfile%%/${keyfile}/g" /etc/nginx/nginx-ssl.conf
fi
