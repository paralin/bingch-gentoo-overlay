# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
K_SECURITY_UNSUPPORTED="1"
ETYPE="sources"
inherit kernel-2
detect_version

DESCRIPTION="Full sources for the Linux kernel, with megi's patch for pinephone"
HOMEPAGE="https://www.kernel.org"

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
MEGI_PATCH_URI="https://xff.cz/kernels/${PV:0:4}/patches/all.patch"
SRC_URI="${KERNEL_URI} ${MEGI_PATCH_URI} -> all-${PV}.patch"

PATCHES=(
	${DISTDIR}/all-${PV}.patch
    ${FILESDIR}/enable-hdmi-output-pinetab.patch
    #${FILESDIR}/improve-brightness.patch
    ${FILESDIR}/enable-jack-detection-pinetab.patch
    ${FILESDIR}/pinetab-bluetooth.patch
    ${FILESDIR}/pinetab-accelerometer.patch
	${FILESDIR}/dts-pinephone-drop-modem-power-node.patch
	${FILESDIR}/dts-headphone-jack-detection.patch
	${FILESDIR}/media-ov5640-Implement-autofocus.patch
	${FILESDIR}/0011-dts-pinetab-hardcode-mmc-numbers.patch
	${FILESDIR}/0002-dts-add-pinetab-dev-old-display-panel.patch
	#${FILESDIR}/0001-arm64-dts-allwinner-pinephone-stop-LEDs-on-suspend.patch
	${FILESDIR}/0010-dts-pinephone-Add-pine64-pinephone-to-compat-list.patch
	${FILESDIR}/0012-pinephone-fix-pogopin-i2c.patch
	${FILESDIR}/0107-quirk-kernel-org-bug-210681-firmware_rome_error.patch
	${FILESDIR}/0177-leds-gpio-make-max_brightness-configurable.patch
	${FILESDIR}/0178-sun8i-codec-fix-headphone-jack-pin-name.patch
	${FILESDIR}/0179-arm64-dts-allwinner-pinephone-improve-device-tree.patch
    ${FILESDIR}/panic-led.patch
    ${FILESDIR}/PATCH-1-4-HID-magicmouse-add-Apple-Magic-Mouse-2-support.patch
    ${FILESDIR}/PATCH-2-4-HID-magicmouse-fix-3-button-emulation-of-Mouse-2.patch
    ${FILESDIR}/PATCH-3-4-HID-magicmouse-fix-reconnection-of-Magic-Mouse-2.patch
    ${FILESDIR}/PATCH-4-4-HID-input-map-battery-capacity-00850065.patch
    #${FILESDIR}/camera-added-bggr-bayer-mode.patch
    #${FILESDIR}/0002-Bluetooth-Fix-LL-PRivacy-BLE-device-fails-to-connect.patch
    #${FILESDIR}/0003-Bluetooth-Fix-attempting-to-set-RPA-timeout-when-unsupported.patch
    #${FILESDIR}/0001-revert-fbcon-remove-now-unusued-softback_lines-cursor-argument.patch
	#${FILESDIR}/0002-revert-fbcon-remove-no-op-fbcon_set_origin.patch
	#${FILESDIR}/0003-revert-fbcon-remove-soft-scrollback-code.patch
)

src_prepare() {
	default
	eapply_user
}

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
	einfo "To build the kernel use the following command:"
	einfo "make Image Image.gz modules"
	einfo "make DTC_FLAGS="-@" dtbs"
	einfo "make install; make modules_intall; make dtbs_install"
	einfo "If you use kernel config coming with this ebuild, don't forget to also copy dracut-pp.conf to /etc/dracut.conf.d/"
	einfo "to make sure proper kernel modules are loaded into initramfs"
	einfo "if you want to cross compile pinephone kernel on amd64 host, follow the https://wiki.gentoo.org/wiki/Cross_build_environment"
	einfo "to setup cross toolchain environment, then create a xmake wrapper like the following, and replace make with xmake in above commands"
	einfo "#!/bin/sh"
	einfo "exec make ARCH='arm64' CROSS_COMPILE='aarch64-unknown-linux-gnu-' INSTALL_MOD_PATH='${SYSROOT}' '$@'"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
