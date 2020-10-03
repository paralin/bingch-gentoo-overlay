#!/bin/sh

#
# Run Mozilla Firefox (bin) on Wayland
#
export MOZ_ENABLE_WAYLAND=1
exec /usr/bin/firefox-bin "$@"
