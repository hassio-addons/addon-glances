#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Glances
# Unprotects this add-on in order to gain access to the Docker socket
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

# Break in case the API is unreachable
if ! hass.api.supervisor.ping; then
    hass.die "Could you contact the HassIO API"
fi

# Docker support is enabled!
if [[ -S "/var/run/docker.sock" ]]; then
    hass.log.info 'Docker support has been enabled.'
    exit "${EX_OK}"
fi

hass.log.fatal "PROTECTION MODE ENABLED!"
hass.log.fatal ""
hass.log.fatal "To be able to use this add-on, you'll need to disable"
hass.log.fatal "protection mode on this add-on. Without it, the add-on"
hass.log.fatal "is unable to access Docker."
hass.log.fatal ""
hass.log.fatal "Steps:"
hass.log.fatal " - Go to the Hass.io Panel."
hass.log.fatal " - Click on the 'Glances' add-on."
hass.log.fatal " - Set the 'Protection mode' switch to off."
hass.log.fatal " - Restart the add-on."
hass.log.fatal ""

exit "${EX_NOK}"
