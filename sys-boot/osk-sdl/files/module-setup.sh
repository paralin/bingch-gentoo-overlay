#!/bin/bash

# called by dracut
check() {
    local _rootdev
    # if cryptsetup is not installed, then we cannot support encrypted devices.
    require_any_binary $systemdutildir/systemd-cryptsetup cryptsetup || return 1
    require_binaries osk-sdl || return 1

    [[ $hostonly ]] || [[ $mount_needs ]] && {
        for fs in "${host_fs_types[@]}"; do
            [[ $fs = "crypto_LUKS" ]] && return 0
        done
        return 255
    }

    return 0
}

# called by dracut
depends() {
    echo dm rootfs-block
    return 0
}

# called by dracut
installkernel() {
    hostonly="" instmods drbg
    arch=$(uname -m)
    [[ $arch == x86_64 ]] && arch=x86
    [[ $arch == s390x ]] && arch=s390
    [[ $arch == aarch64 ]] && arch=arm64
    instmods dm_crypt =crypto =drivers/crypto =arch/$arch/crypto
}


# called by dracut
install() {
    if [[ $hostonly ]] && [[ -f $dracutsysrootdir/etc/crypttab ]]; then
        # filter /etc/crypttab for the devices we need
        while read _mapper _dev _luksfile _luksoptions || [ -n "$_mapper" ]; do
            [[ $_mapper = \#* ]] && continue
            [[ $_dev ]] || continue

            [[ $_dev == PARTUUID=* ]] && \
                _dev="/dev/disk/by-partuuid/${_dev#PARTUUID=}"

            [[ $_dev == UUID=* ]] && \
                _dev="/dev/disk/by-uuid/${_dev#UUID=}"

            [[ $_dev == ID=* ]] && \
                _dev="/dev/disk/by-id/${_dev#ID=}"

            echo "$_dev $(blkid $_dev -s UUID -o value)" >> "${initdir}/etc/block_uuid.map"

            # loop through the options to check for the force option
            luksoptions=${_luksoptions}
            OLD_IFS="${IFS}"
            IFS=,
            set -- ${luksoptions}
            IFS="${OLD_IFS}"

            while [ $# -gt 0 ]; do
                case $1 in
                    force)
                        forceentry="yes"
                        break
                        ;;
                esac
                shift
            done

            # include the entry regardless
            if [ "${forceentry}" = "yes" ]; then
                echo "$_mapper $_dev $_luksfile $_luksoptions"
            else
                for _hdev in "${!host_fs_types[@]}"; do
                    [[ ${host_fs_types[$_hdev]} == "crypto_LUKS" ]] || continue
                    if [[ $_hdev -ef $_dev ]] || [[ /dev/block/$_hdev -ef $_dev ]]; then
                        echo "$_mapper $_dev $_luksfile $_luksoptions"
                        break
                    fi
                done
            fi
        done < $dracutsysrootdir/etc/crypttab > $initdir/etc/crypttab
        mark_hostonly /etc/crypttab
    fi

    inst_simple "/etc/osk.conf" "/etc/osk.conf"
    #inst_simple "/etc/crypttab" "/etc/crypttab"
    inst_simple "/usr/share/glvnd/egl_vendor.d/50_mesa.json" "/usr/share/glvnd/egl_vendor.d/50_mesa.json"
    inst_multiple osk-sdl

    # mesa and cogl lib
    equery f mesa cogl | grep ".so$" | while read -r so; do
      inst_libdir_file $(basename ${so})*
    done

    inst_hook cmdline 60 "$moddir/osk-sdl.sh"

    dracut_need_initqueue
}
