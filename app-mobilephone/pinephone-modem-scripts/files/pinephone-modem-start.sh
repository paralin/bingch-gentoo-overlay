#!/bin/sh

echo "Enabling EG25 WWAN module"
#if we have modem-power sysfs then use it
if [ -e /sys/class/modem-power/modem-power/device/powered ]
then
  echo 1 > /sys/class/modem-power/modem-power/device/powered
  exit 
fi

# DTR is:
# - PL6/GPIO358 on BH (1.1)
# - PB2/GPIO34 on CE (1.2)

if grep -q 1.1 /proc/device-tree/model
then
	DTR=358
else
	DTR=34
fi

# GPIO35 is PWRKEY
# GPIO68 is RESET_N
# GPIO231 is WAKEUP_IN on BH and AP_READY (active low) on CE
# GPIO232 is W_DISABLE#
for i in 35 68 231 232 $DTR
do
	[ -e /sys/class/gpio/gpio$i ] && continue
	echo $i > /sys/class/gpio/export || return 1
	echo out > /sys/class/gpio/gpio$i/direction || return 1
done

echo 0 > /sys/class/gpio/gpio68/value || return 1
echo 0 > /sys/class/gpio/gpio231/value || return 1
echo 0 > /sys/class/gpio/gpio232/value || return 1
echo 0 > /sys/class/gpio/gpio$DTR/value || return 1

( echo 1 > /sys/class/gpio/gpio35/value && sleep 2 && echo 0 > /sys/class/gpio/gpio35/value ) || return 1
