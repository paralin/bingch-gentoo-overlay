#!/bin/sh

# Fix Qt applications
export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export QT_QUICK_CONTROLS_MOBILE=1

# Kirigami
export KIRIGAMI_LOWPOWER_HARDWARE=1

# Fix Firefox
export MOZ_ENABLE_WAYLAND=1

# Use custom feedbackd theme
export FEEDBACK_THEME=/usr/share/feedbackd/themes/manjaro.json

# Give us some room to configure things:
export XDG_DATA_DIRS
XDG_DATA_DIRS="/usr/share/manjaro:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"
