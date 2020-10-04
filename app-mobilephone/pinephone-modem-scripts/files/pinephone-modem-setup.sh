#!/bin/bash
# no need if we're have modem-power driver
[ -e /sys/class/modem-power/modem-power/device/powered ] && exit

MODEM_ID=""

if grep -q 1.1 /proc/device-tree/model; then
	REVISION="BH"
fi

get_modem_id()
{
    MODEM_LIST="`mmcli -L | grep QUECTEL`"
    if [ "$MODEM_LIST" ]; then
        # mmcli output is "   /org/freedesktop/ModemManager1/Modem/MODEM_ID ..."
        # MODEM_PATH will store the D-Bus object path, from which we'll extract
        # MODEM_ID
        MODEM_PATH="`echo "$MODEM_LIST" | sed 's%[^/]*\(/[^ ]*\).*%\1%'`"
        MODEM_ID=`basename "$MODEM_PATH"`
    fi
}

configure_modem()
{
    COMMAND=$1
    VALUE=$2
    STATE=""

    if [ "$COMMAND" = "QCFG" -o "$COMMAND" = "QURCCFG" ]; then
        SUBCMD=`echo $VALUE | cut -d ',' -f 1`
        STATE=`mmcli -m $MODEM_ID --command="AT+$COMMAND=$SUBCMD" | sed "s%response: '+$COMMAND: \(.*\)'%\1%"`
    else
        STATE=`mmcli -m $MODEM_ID --command="AT+$COMMAND?" | sed "s%response: '+$COMMAND: \(.*\)'%\1%"`
    fi

    if [[ $STATE != $VALUE* ]]; then
        mmcli -m $MODEM_ID --command="AT+$COMMAND=$VALUE" > /dev/null 2>&1
    fi
}

# Wait for the modem to be available
while [ ! "$MODEM_ID" ]; do
    sleep 1
    get_modem_id
done

# Check the current DAI configuration, and change it if necessary
configure_modem "QDAI" "1,0,0,2,0,1,1,1"

# Check the current Ring Indicator configuration, and change it if necessary
configure_modem "QCFG" '"risignaltype","physical"'

# Enable VoLTE
configure_modem "QCFG" '"ims",1'

if [ "$REVISION" = "BH" ]; then
    # BH revision doesn't have the AP_READY signal connected, so we delay URC
    # reporting as much as possible
    configure_modem "QCFG" '"urc/ri/ring","pulse",2000,1000,5000,"off",1'
    configure_modem "QCFG" '"urc/ri/smsincoming","pulse",2000'
    configure_modem "QCFG" '"urc/ri/other","pulse",2000'
    configure_modem "QCFG" '"urc/delay",1'
else
    # We need to enable AP_READY (active low) on CE phones
    configure_modem "QCFG" '"apready",1,0,500'
fi

# Make sure URCs are always output on the USB interface, not the UART
configure_modem "QURCCFG" '"urcport","usbat"'

# Enable GPS
# TODO: move all of this to a dedicated user service/daemon and switch GPS
# according to user preferences (org.gnome.system.location enabled)
configure_modem "QGPS" "1"

# Location can't be setup while the SIM is locked, loop until we get there
# (yes, that's nasty)
while ! mmcli -m $MODEM_ID --location-enable-gps-raw --location-enable-gps-nmea; do
    sleep 5
done

# /dev/ttyS2 is a UART through which we can issue AT commands, configure it
# properly for future use
stty -F /dev/ttyS2 115200
