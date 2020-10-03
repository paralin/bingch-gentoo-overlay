#!/bin/sh

#
# Run Mozilla Firefox (bin) on X11
#
export MOZ_DISABLE_WAYLAND=1
exec /usr/bin/firefox-bin "$@"
