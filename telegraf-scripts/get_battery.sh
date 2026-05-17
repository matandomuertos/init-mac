#!/bin/bash

# 1. Capture the entire power profile once to avoid redundant hardware polls
POWER_INFO=$(/usr/sbin/system_profiler SPPowerDataType)

# 2. Parse all required fields using awk / grep
LEVEL=$(echo "$POWER_INFO" | grep "State of Charge" | awk '{print $5}')
CYCLES=$(echo "$POWER_INFO" | grep "Cycle Count" | awk '{print $3}')
HEALTH=$(echo "$POWER_INFO" | grep "Maximum Capacity" | awk '{print $3}' | tr -d '%')

# 3. Check AC Charger connection status
IS_CONNECTED=$(echo "$POWER_INFO" | grep -A 2 "AC Charger Information:" | grep "Connected:" | awk '{print $2}')

# 4. Map connection state explicitly to numeric 1 or 0
if [ "$IS_CONNECTED" = "Yes" ]; then
    CONNECTED=1
else
    CONNECTED=0
fi

# 5. Output standard Line Protocol using explicit integer syntax for all fields
echo "battery_info level=${LEVEL}i,health=${HEALTH}i,cycles=${CYCLES}i,connected=${CONNECTED}i"