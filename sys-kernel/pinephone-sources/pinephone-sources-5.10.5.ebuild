# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
K_SECURITY_UNSUPPORTED="1"
ETYPE="sources"
inherit kernel-2
detect_version

DESCRIPTION="Full sources for the Linux kernel"
HOMEPAGE="https://www.kernel.org"

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
MEGI_PATCH_URI="https://xff.cz/kernels/5.10/patches/all.patch"
SRC_URI="${KERNEL_URI} ${MEGI_PATCH_URI} -> all-5.10.patch"

PATCHES=(
	${DISTDIR}/all-5.10.patch
    ${FILESDIR}/panic-led.patch
    ${FILESDIR}/enable-hdmi-output-pinetab.patch
    ${FILESDIR}/improve-brightness.patch
    ${FILESDIR}/enable-jack-detection-pinetab.patch
    ${FILESDIR}/pinetab-bluetooth.patch
    ${FILESDIR}/pinetab-accelerometer.patch
    ${FILESDIR}/camera-autofocus.patch
    ${FILESDIR}/media-ov5640-dont-break-when-firmware-for-autofocus-isnt-loaded.patch
    ${FILESDIR}/camera-added-bggr-bayer-mode.patch
    #${FILESDIR}/0002-Bluetooth-Fix-LL-PRivacy-BLE-device-fails-to-connect.patch
    ${FILESDIR}/0003-Bluetooth-Fix-attempting-to-set-RPA-timeout-when-unsupported.patch
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
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
