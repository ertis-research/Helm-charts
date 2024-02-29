#!/bin/sh
source ditto-connection.sh

DITTO_DEVOPS_USER_PW="devops:$(cat /var/run/opentwins/ditto-gw-users/devops-password)"
DITTO_BASIC_USER_PW="{{.Values.ditto.global.basicAuthUsers.ditto.user}}:{{.Values.ditto.global.basicAuthUsers.ditto.password}}"
DITTO_POLICIES_BASE_URL="http://{{ include "opentwins.ditto.fullname" . }}-nginx:8080/api/2/policies"

echo "Adding default policy [URL: ${DITTO_POLICIES_BASE_URL}/default:basic_policy]"
response_body_and_status=$(curl --silent --write-out "\n%{http_code}" \
    -X PUT -u "$DITTO_BASIC_USER_PW" --header 'Content-Type: application/json' \
    --data-binary "@basic-policy.json" "${DITTO_POLICIES_BASE_URL}/default:basic_policy")
check_status $? "$response_body_and_status"
