#!/bin/bash
# workaround duet sound card issue, stop/start pipewire before/after suspend
if [ "${1}" = "pre" ]; then
for line in "$(ps -eo pid,user:32,args | grep "dbus-daemon.*--session" | grep -v grep | xargs)"
do
pid="$(echo "$line" | cut -d' ' -f 1)"
user="$(echo "$line" | cut -d' ' -f 2)"
bus_addr="$(sed -n 's/.*[\x0]DBUS_SESSION_BUS_ADDRESS=\([^\x0]*\)\x0.*/\1\n/p' /proc/$pid/environ)"
DBUS_SESSION_BUS_ADDRESS="$bus_addr" sudo -u $user -E /bin/systemctl --user stop pipewire*
done
elif [ "${1}" = "post" ]; then
for line in "$(ps -eo pid,user:32,args | grep "dbus-daemon.*--session" | grep -v grep | xargs)"
do
pid="$(echo "$line" | cut -d' ' -f 1)"
user="$(echo "$line" | cut -d' ' -f 2)"
bus_addr="$(sed -n 's/.*[\x0]DBUS_SESSION_BUS_ADDRESS=\([^\x0]*\)\x0.*/\1\n/p' /proc/$pid/environ)"
DBUS_SESSION_BUS_ADDRESS="$bus_addr" sudo -u $user -E /bin/systemctl --user start pipewire.socket pipewire-media-session.service pipewire-pulse.socket
done
fi
