#!/bin/sh

battery=$(acpi)

DIR="/home/jango/.customApps/batteryNotifications/audio/"
BATTERYFULLYCHARGED="charged"
BATTERYDISCHARGED="discharged"
LANG=""
EXT=".wav"

if [[ "$battery" =~ "Full" ]]; then
  aplay -q "$DIR$BATTERYFULLYCHARGED$LANG$EXT"

elif [[ "$battery" =~ "Discharging" ]]; then
  percentage=${battery:24:2}
  percentage=${percentage//%}

  if [ "$percentage" -lt 20 ]; then
    aplay -q "$DIR$BATTERYDISCHARGED$LANG$EXT"
  fi

else
    echo "do nothing"
fi
