#!/bin/bash

# called by dracut
check() {
    require_binaries osk-sdl || return 1
    return 255
}

# called by dracut
depends() {
    return 0
}

# called by dracut
install() {
    inst_simple "/etc/osk.conf" "/etc/osk.conf"
    inst_simple "/etc/crypttab" "/etc/crypttab"
    inst_simple "/usr/share/glvnd/egl_vendor.d/50_mesa.json" "/usr/share/glvnd/egl_vendor.d/50_mesa.json"

    # mesa and cogl lib
    equery f mesa cogl | grep ".so$" | while read -r so
    do 
      inst_libdir_file $(basename ${so})*
    done

# called by dracut
install() {
    inst_hook cmdline 60 "$moddir/osk-sdl"
}
