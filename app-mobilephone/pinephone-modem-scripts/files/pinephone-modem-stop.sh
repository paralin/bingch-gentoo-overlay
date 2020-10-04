#!/bin/sh
echo "Disabling EG25 WWAN module"
#if we have modem-power sysfs then use it
if [ -e /sys/class/modem-power/modem-power/device/powered ]
then
  echo 0 > /sys/class/modem-power/modem-power/device/powered
  sleep 2 
  exit
fi

echo 1 > /sys/class/gpio/gpio68/value
echo 1 > /sys/class/gpio/gpio232/value

echo 1 > /sys/class/gpio/gpio35/value && sleep 2 && echo 0 > /sys/class/gpio/gpio35/value
sleep 30 # Wait for the module to power off
