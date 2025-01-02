#!/bin/bash
set -e -u

# Only run, when connected to the on board WiFi
current_wifi_name="$(networksetup -listallhardwareports | awk '/Wi-Fi/{getline; print $2}' | xargs networksetup -getairportnetwork)"
if [[ "$current_wifi_name" != 'Current Wi-Fi Network: WIFIonICE' ]]
then
    exit 0
fi

#ICON=''
#ICON='🚄'

# Next station and arrival
TRIP_INFO=$(curl https://iceportal.de/api1/rs/tripInfo/trip 2> /dev/null || true)

NEXT_STOP_EVA=$(echo "$TRIP_INFO" | jq -r '.trip.stopInfo.actualNext')

if [[ -z "$NEXT_STOP_EVA" ]]
then
    output_next_stop=""
else
    STATION_INFO=$(echo "$TRIP_INFO" | jq -r ".trip.stops[] | select(.station.evaNr == \"$NEXT_STOP_EVA\")")
    STATION_NAME=$(echo "$STATION_INFO" | jq -r ".station.name")
    SCHEDULED_ARRIVAL_UNIX=$(echo "$STATION_INFO" | jq -r "(.timetable.scheduledArrivalTime | tonumber) / 1000")
    ACTUAL_ARRIVAL_UNIX=$(echo "$STATION_INFO" | jq -r "(.timetable.actualArrivalTime | tonumber) / 1000")
    ARRIVAL_DELAY=$(echo "$STATION_INFO" | jq -r ".timetable.arrivalDelay")

    #output_next_stop="$STATION_NAME – $(date -r "$SCHEDULED_ARRIVAL_UNIX" +'%H:%M') / $(date -r "$ACTUAL_ARRIVAL_UNIX" +'%H:%M')"
    output_next_stop="$STATION_NAME ${ARRIVAL_DELAY:-+0} / $(date -r "$ACTUAL_ARRIVAL_UNIX" +'%H:%M')"
fi

# Current speed
STATUS_RESPONSE=$(curl https://iceportal.de/api1/rs/status 2> /dev/null || true)

if [[ -z "$STATUS_RESPONSE" ]]
then
    output_speed=""
else
    export LC_NUMERIC="en_US.UTF-8"
    speed_float=$(echo "$STATUS_RESPONSE" | jq -r '.speed')
    speed=$(printf '%.0f' "$speed_float")
    if [[ $speed -gt 0 ]]
    then
        output_speed="$speed km/h"
    else
        output_speed="0 km/h"
    fi
fi

# Combine outputs
if [[ -n "$output_next_stop" && -n "$output_speed" ]]
then
  echo "$output_next_stop – $output_speed"
elif [[ -n "$output_next_stop" ]]
then
  echo "$output_next_stop"
elif [[ -n "$output_speed" ]]
then
  echo "$output_speed"
fi