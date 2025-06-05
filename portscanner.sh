#!/bin/bash

TIMEOUT=1

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

usage() {
    echo "A simple Bash Port Scanner"
    echo "--------------------------"
    echo "Usage: $0 <host> <ports>"
    echo
    echo "Arguments:"
    echo "  <host>      The target IP address or domain name to scan."
    echo "  <ports>     The port(s) to scan. Can be:"
    echo "                - A single port (e.g., 80)"
    echo "                - A comma-separated list (e.g., 80,443,8080)"
    echo "                - A hyphenated range (e.g., 20-25)"
    echo
    echo "Example:"
    echo "  $0 scanme.nmap.org 80"
    echo "  $0 192.168.1.1 22,80,443"
    echo "  $0 example.com 1-1024"
    exit 1
}

scan_port() {
    local host=$1
    local port=$2
    
    (timeout $TIMEOUT bash -c "echo > /dev/tcp/$host/$port") &>/dev/null

    if [ $? -eq 0 ]; then
        echo -e "Port $port: ${GREEN}OPEN${NC}"
    else
        echo -e "Port $port: ${RED}CLOSED or FILTERED${NC}"
    fi
}

if [ "$#" -ne 2 ]; then
    usage
fi

TARGET_HOST=$1
PORTS_TO_SCAN=$2

echo -e "${YELLOW}Starting scan on host: $TARGET_HOST${NC}"
echo "-----------------------------------"

if [[ $PORTS_TO_SCAN == *-* ]]; then
    IFS='-' read -r START_PORT END_PORT <<< "$PORTS_TO_SCAN"
    for ((port=START_PORT; port<=END_PORT; port++)); do
        scan_port "$TARGET_HOST" "$port"
    done
elif [[ $PORTS_TO_SCAN == *,* ]]; then
    echo "$PORTS_TO_SCAN" | tr ',' '\n' | while read -r port; do
        scan_port "$TARGET_HOST" "$port"
    done
else
    scan_port "$TARGET_HOST" "$PORTS_TO_SCAN"
fi

echo "-----------------------------------"
echo -e "${YELLOW}Scan complete.${NC}"
