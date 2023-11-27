#!/bin/sh
source ditto-connection.sh

#######################################################################################################################################
# This code is based on the file: https://github.com/eclipse/packages/blob/master/packages/cloud2edge/post-install/post-install.sh
#######################################################################################################################################

# Variables
# ----------------------------------------------
MOSQUITTO_BASE_URL="tcp://{{ include "opentwins.mosquitto.fullname" . }}:1883"


# Main code
# ----------------------------------------------
echo "Mosquitto base url: $MOSQUITTO_BASE_URL"
add_connection_in_ditto "mosquitto-target-connection" "mosquitto-target-connection.json"
echo "DONE"
