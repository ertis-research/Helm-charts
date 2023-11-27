#!/bin/bash

DITTO_DEVOPS_USER_PW="devops:$(cat /var/run/opentwins/ditto-gw-users/devops-password)"
DITTO_CONNECTIONS_BASE_URL="http://{{ include "opentwins.ditto.fullname" . }}-nginx:8080/api/2/connections"
DITTO_THINGS_BASE_URL="http://{{ include "opentwins.ditto.fullname" . }}-nginx:8080/api/2/things"

check_status() {
    exit_code="$1"
    response_body_and_status="$2"

    if [ "$exit_code" -ne 0 ]; then
        echo "curl command failed [exit-code: $exit_code]"
        exit 1
    fi
    http_code=$(echo "$response_body_and_status" | tail -n1) # get last line
    body=$(echo "$response_body_and_status" | sed '$ d')     # get all but last line
    # echo "DEBUG: Got [status: $http_code, response: $body]"
    if [ "$http_code" -eq "409" ]; then
        # HTTP 409 Conflict (e.g. "device already exists") ignored here
        echo "Ignoring HTTP response 409 [$body]"
    elif [ "$http_code" -ge "400" ]; then
        echo "HTTP request failed [status: $http_code, response: $body]"
        exit 1
    else 
        echo "[status: $http_code, response: $body]"
    fi
}

add_connection_in_ditto() {
    connection_id_prefix="$1"
    http_request_body_file="$2"

    connection_id="${connection_id_prefix}"
    echo "Adding ditto connection '$connection_id' [URL: ${DITTO_CONNECTIONS_BASE_URL}/${connection_id}]"
    response_body_and_status=$(curl --silent --write-out "\n%{http_code}" \
        -X PUT -u "$DITTO_DEVOPS_USER_PW" --header 'Content-Type: application/json' \
        --data-binary "@$http_request_body_file" "${DITTO_CONNECTIONS_BASE_URL}/${connection_id}")
    check_status $? "$response_body_and_status"
}