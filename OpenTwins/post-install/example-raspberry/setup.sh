#!/bin/sh
source ditto-connection.sh

#######################################################################################################################################
# This code is based on the file: https://github.com/eclipse/packages/blob/master/packages/cloud2edge/post-install/post-install.sh
#######################################################################################################################################

# Variables
# ----------------------------------------------
EXTENDED_API_BASE_URL="http://{{ include "opentwins.extendedAPI.fullname" . }}:8080/api"



# Main code
# ----------------------------------------------

echo "Create DHT22 type"
response_body_and_status=$(curl --silent --write-out "\n%{http_code}" \
    -X PUT --header 'Content-Type: application/json' \
    --data-binary "@type.json" "${EXTENDED_API_BASE_URL}/types/example:DHT22")
http_code=$(echo "$response_body_and_status" | tail -n1) # get last line
body=$(echo "$response_body_and_status" | sed '$ d')     # get all but last line
echo "[status: $http_code, response: $body]"
echo "DONE"

echo "Connection with raspberry simulator"
add_connection_in_ditto "example-raspberry-source-connection" "connection.json"
echo "DONE"

