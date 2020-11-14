# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="8"
K_NODRYRUN="1"

inherit kernel-2
detect_version
detect_arch

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
HOMEPAGE="https://dev.gentoo.org/~mpagano/genpatches"
IUSE="experimental"

DESCRIPTION="Full sources including the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
MEGI_PATCH_URI="https://xff.cz/kernels/5.9/patches/all.patch"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${MEGI_PATCH_URI}"


PATCHES=(
	${DISTDIR}/all.patch
    ${FILESDIR}/wifi-power-saving.patch
    ${FILESDIR}/panic-led.patch
    ${FILESDIR}/enable-hdmi-output-pinetab.patch
    ${FILESDIR}/improve-brightness.patch
    ${FILESDIR}/enable-jack-detection-pinetab.patch
    ${FILESDIR}/pinetab-bluetooth.patch
    ${FILESDIR}/pinetab-accelerometer.patch
    ${FILESDIR}/camera-added-bggr-bayer-mode.patch
    ${FILESDIR}/remove-v4l2-flash-pp.patch
    ${FILESDIR}/0001-revert-fbcon-remove-now-unusued-softback_lines-cursor-argument.patch
	${FILESDIR}/0002-revert-fbcon-remove-soft-scrollback-code.patch
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
