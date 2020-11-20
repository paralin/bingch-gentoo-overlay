#!/bin/sh

# DTR is:
# - PL6/GPIO358 on BH (1.1)
# - PB2/GPIO34 on CE (1.2)

echo "Enabling EG25 WWAN module"
echo 1 > /sys/class/modem-power/modem-power/device/powered
