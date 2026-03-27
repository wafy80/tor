#!/bin/bash

# Start Privoxy (in background, non blocking)
privoxy /etc/privoxy/config &

# Start Tor
tor &

# Get the PID of Tor (main service to monitor)
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
