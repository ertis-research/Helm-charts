#!/bin/sh
source ditto-connection.sh

#######################################################################################################################################
# This code is based on the file: https://github.com/eclipse/packages/blob/master/packages/cloud2edge/post-install/post-install.sh
#######################################################################################################################################

# Variables
# ----------------------------------------------
EXTENDED_API_BASE_URL="http://{{ include "opentwins.extendedAPI.fullname" . }}:8080/api"
DITTO_DEVOPS_USER_PW="devops:$(cat /var/run/opentwins/ditto-gw-users/devops-password)"
DITTO_BASIC_USER_PW="{{.Values.ditto.global.basicAuthUsers.ditto.user}}:{{.Values.ditto.global.basicAuthUsers.ditto.password}}"
DITTO_POLICIES_BASE_URL="http://{{ include "opentwins.ditto.fullname" . }}-nginx:8080/api/2/policies"
echo ${EXTENDED_API_BASE_URL}

# Main code
# ----------------------------------------------

echo "Adding example policy [URL: ${DITTO_POLICIES_BASE_URL}/example:very_insecure_policy]"
response_body_and_status=$(curl --silent --write-out "\n%{http_code}" \
    -X PUT -u "$DITTO_BASIC_USER_PW" --header 'Content-Type: application/json' \
    --data-binary "@policy.json" "${DITTO_POLICIES_BASE_URL}/example:very_insecure_policy")
check_status $? "$response_body_and_status"

echo "Create raspberry type"

res=$(curl -X PUT -H "Content-Type: application/json" -d @type_raspberry.json ${EXTENDED_API_BASE_URL}/types/example:raspberry_type)
echo "$res"
echo "DONE"

echo "Create raspberry twin"
res=$(curl -X POST -H "Content-Type: application/json" ${EXTENDED_API_BASE_URL}/types/example:raspberry_type/create/example:raspberry)
echo "$res"
echo "DONE"


echo "Create DHT22 type"
res=$(curl -X PUT -H "Content-Type: application/json" -d @type_DHT22.json ${EXTENDED_API_BASE_URL}/types/example:raspberry_type/children/example:DHT22/2)
echo "$res"
echo "DONE"

echo "Create DHT22_1 twin"
res=$(curl -X POST -H "Content-Type: application/json" ${EXTENDED_API_BASE_URL}/types/example:DHT22/create/raspberry:DHT22_1)
echo "$res"
echo "DONE"

echo "Create DHT22_2 twin"
res=$(curl -X POST -H "Content-Type: application/json" ${EXTENDED_API_BASE_URL}/types/example:DHT22/create/raspberry:DHT22_2)
echo "$res"
echo "DONE"

echo "Assign to the parent"
res=$(curl -X PUT -H "Content-Type: application/json" ${EXTENDED_API_BASE_URL}/twins/example:raspberry/children/raspberry:DHT22_1)
echo "$res"
res=$(curl -X PUT -H "Content-Type: application/json" ${EXTENDED_API_BASE_URL}/twins/example:raspberry/children/raspberry:DHT22_2)
echo "$res"
echo "DONE"


echo "Connection with raspberry simulator"
add_connection_in_ditto "example-raspberry-source-connection" "connection.json"
echo "DONE"

