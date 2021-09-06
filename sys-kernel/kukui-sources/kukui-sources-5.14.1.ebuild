# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
K_SECURITY_UNSUPPORTED="1"
ETYPE="sources"
inherit kernel-2
detect_version

HOMEPAGE="https://www.kernel.org"
SRC_URI="${KERNEL_URI}"

KEYWORDS="~arm64"

DESCRIPTION="Full sources for the Linux kernel, with patches for kukui chromebook"

PATCHES=(
	# From https://github.com/Maccraft123/Cadmium/tree/master/baseboard/kukui/patches
    ${FILESDIR}/cci-1.patch
    ${FILESDIR}/cci-2.patch
    ${FILESDIR}/cci-3.patch
    ${FILESDIR}/cci-4.patch
    ${FILESDIR}/cci-5.patch
    ${FILESDIR}/cci-6.patch
    ${FILESDIR}/cci-7.patch
    ${FILESDIR}/cci-8.patch
    ${FILESDIR}/drm.patch
    ${FILESDIR}/gpu-vsram.patch
    ${FILESDIR}/move-gpu-opp-to-3.patch
    ${FILESDIR}/mutex-gce-events.patch
    ${FILESDIR}/opp-multi-regulator.patch
    ${FILESDIR}/panel-dts-rotation.patch
    ${FILESDIR}/panel-dts-rotation_sku0.patch
    ${FILESDIR}/sound_1.patch
    ${FILESDIR}/sound_2.patch
    ${FILESDIR}/usb.patch
	# From https://github.com/hexdump0815/linux-mainline-mediatek-mt81xx-kernel/tree/master/misc.cbm/patches/5.13.2
	${FILESDIR}/mt8183-disable-unsupported-thermal-zones.patch
	${FILESDIR}/mt8183-fix-mmc-order.patch
	${FILESDIR}/mt8183-panel-orientation.patch
	${FILESDIR}/mt8183-silence-some-log-spam.patch
	${FILESDIR}/mt8183-sound-juniper.patch
	# cherry-pick from https://patchwork.kernel.org/project/linux-mediatek
	${FILESDIR}/v3-media-mtk-vpu-Ensure-alignment-of-8-for-DTCM-buffer.patch
	${FILESDIR}/media-mediatek-support-mdp3-on-mt8183-platform-fix.patch
	${FILESDIR}/Introducing-an-attribute-to-select-the-time-setting.patch
	${FILESDIR}/ASoC-mediatek-common-handle-NULL-case-in-suspend-resume-function.patch
	${FILESDIR}/drm-panel-boe-tv101wum-nl6-Support-enabling-a-3.3V-rail.patch
	#${FILESDIR}/Add-support-to-the-mmsys-driver-to-be-a-reset-controller-fix.patch
	#${FILESDIR}/Using-component-framework-to-support-multi-hardware-decode.patch

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
	einfo "if you want to cross compile arm64 kernel on amd64 host, follow the https://wiki.gentoo.org/wiki/Cross_build_environment"
	einfo "to setup cross toolchain environment, then create a xmake wrapper like the following, and replace make with xmake in above commands"
	einfo "#!/bin/sh"
	einfo "exec make ARCH='arm64' CROSS_COMPILE='aarch64-unknown-linux-gnu-' INSTALL_MOD_PATH='${SYSROOT}' '$@'"
}
