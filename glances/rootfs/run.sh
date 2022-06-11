#!/usr/bin/env bashio
# ==============================================================================
# Home Assistant Community Add-on: Glances
# Run the Glances add-on
# ==============================================================================
#
# WHAT IS THIS FILE?!
#
# The Glances add-on runs in the host PID namespace, therefore it cannot
# use the regular S6-Overlay; hence this add-on uses a "old school" script
# to run; with a couple of "hacks" to make it work.
# ==============================================================================
/etc/cont-init.d/banner.sh
/etc/cont-init.d/glances.sh
/etc/cont-init.d/nginx.sh

# Start NGiNX
/etc/services.d/nginx/run &

# InfluxDB export
/etc/services.d/influxdb/run &

# Start Glances
exec /etc/services.d/glances/run
