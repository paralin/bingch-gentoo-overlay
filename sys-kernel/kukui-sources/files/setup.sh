if [[ $# < 1 ]]
then
  ver=$(uname -r)
else
#ver=$(uname -r)
  ver=$1
fi
echo $ver
dd if=/dev/zero of=bootloader.bin bs=512 count=1
mkimage -D "-I dts -O dtb -p 2048" -f auto -A arm64 -O linux -T kernel -C lz4 -a 0 -d /boot/Image.lz4-${ver} -b /boot/dtbs/${ver}/mediatek/mt8183-kukui-krane-sku0.dtb -b /boot/dtbs/${ver}/mediatek/mt8183-kukui-krane-sku176.dtb -i /boot/initramfs-${ver}.img kernel.itb
vbutil_kernel --pack vmlinux.kpart --keyblock /usr/share/vboot/devkeys/kernel.keyblock --signprivate /usr/share/vboot/devkeys/kernel_data_key.vbprivk --version 1 --config cmdline --bootloader bootloader.bin --vmlinuz kernel.itb --arch arm
cp vmlinux.kpart /boot/vmlinux.kpart-${ver}
echo "now you can use command"
echo "dd if=/boot/vmlinux.kpart-${ver} of=/path/to/bootpart"
echo "and cgpt command to config chromebook to boot to new kernel"
