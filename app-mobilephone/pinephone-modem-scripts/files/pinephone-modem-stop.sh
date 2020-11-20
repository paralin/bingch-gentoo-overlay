#!/bin/sh

if [ -d /sys/class/modem-power/modem-power ]; then
	echo "Disabling EG25 WWAN module (modem_power)"
	echo 0 > /sys/class/modem-power/modem-power/device/powered
else
	# Keep legacy code path for shutdown of old kernel after upgrade
	echo "Disabling EG25 WWAN module (legacy)"
	echo 1 > /sys/class/gpio/gpio68/value
	echo 1 > /sys/class/gpio/gpio232/value
	echo 1 > /sys/class/gpio/gpio35/value && sleep 2 && echo 0 > /sys/class/gpio/gpio35/value
	sleep 30 # Wait for the module to power off
fi
