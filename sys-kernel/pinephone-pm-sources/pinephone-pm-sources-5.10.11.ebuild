# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
K_SECURITY_UNSUPPORTED="1"
ETYPE="sources"
inherit kernel-2
detect_version

DESCRIPTION="Full sources for the Linux kernel with megi and postmarketOS patches"
HOMEPAGE="https://www.kernel.org"

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
MEGI_PATCH_URI="https://xff.cz/kernels/5.10/patches/all.patch"
SRC_URI="${KERNEL_URI} ${MEGI_PATCH_URI} -> all-${PV}.patch"

PATCHES=(
	${DISTDIR}/all-${PV}.patch
    ${FILESDIR}/0001-dts-add-dontbeevil-pinephone-devkit.patch
	${FILESDIR}/0002-dts-add-pinetab-dev-old-display-panel.patch
	${FILESDIR}/0003-media-gc2145-Added-BGGR-bayer-mode.patch
	${FILESDIR}/0004-dts-pinetab-add-missing-bma223-ohci1.patch
	${FILESDIR}/0005-dts-pinetab-make-audio-routing-consistent-with-pinep.patch
	${FILESDIR}/0006-arm64-dts-allwinner-Add-bluetooth-node-to-the-PineTa.patch
	${FILESDIR}/0007-dts-pinephone-remove-bt-firmware-suffix.patch
	${FILESDIR}/0008-media-ov5640-Implement-autofocus.patch
	${FILESDIR}/0009-leds-gpio-set-max_brightness-to-1.patch
	${FILESDIR}/0010-dts-pinephone-Add-pine64-pinephone-to-compat-list.patch
	${FILESDIR}/0011-dts-pinetab-hardcode-mmc-numbers.patch
	${FILESDIR}/0012-dts-pinephone-drop-modem-power-node.patch
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
