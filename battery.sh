#!/bin/sh

# First of all, make this script executable
# chmod +x battery.sh
#
# Install acpi
# sudo apt-get install acpi (Debian/Ubuntu)
# sudo dnf install acpi (RedHat/CentOS/Fedora)
# Then create a schedule to run the script every 5 minutes
# using crontab
# crontab -e
# */5 * * * * ~/bin/batteryNotifications/battery.sh

# Get the battery status and store it in a variable
battery=$(acpi)

# The audio files location
DIR="$HOME/bin/batteryNotifications/audio/"
BATTERYFULLYCHARGED="charged"
BATTERYDISCHARGED="discharged"
LANG=""
EXT=".wav"

if [[ "$battery" =~ "Full" ]]; then
  aplay -q "$DIR$BATTERYFULLYCHARGED$LANG$EXT"
  notify-send 'Battery fully charged' 'please unplug your computer!' -u critical -i battery-full-charging

# In my case, sometimes, the battery status never reach 100%
elif [[ "$battery" =~ "99" ]]; then
  aplay -q "$DIR$BATTERYFULLYCHARGED$LANG$EXT"
  notify-send 'Battery fully charged' 'please unplug your computer!' -u critical -i battery-full-charging

elif [[ "$battery" =~ "Discharging" ]]; then
  percentage=${battery:24:2}
  percentage=${percentage//%}

  if [ "$percentage" -lt 10 ]; then
    aplay -q "$DIR$BATTERYDISCHARGED$LANG$EXT"
    notify-send 'Battery low' 'please plug your computer!' -u critical -i battery-empty
  fi

else
    echo "do nothing"

fi
