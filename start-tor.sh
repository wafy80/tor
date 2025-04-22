#!/bin/bash

# Start Tor
tor &

# Get the PID of Tor
TOR_PID=$!

# Function to check the status of Tor
check_tor() {
    kill -0 "$TOR_PID" 2>/dev/null
    return $?
}

# Infinite loop to monitor Tor
while true; do
    if ! check_tor; then
        echo "Tor is not running. Restarting..."
        tor &
        TOR_PID=$!
    fi
    sleep 10
done