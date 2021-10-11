# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
UNIPATCH_STRICTORDER="yes"
K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
K_NOUSEPR="yes"
K_SECURITY_UNSUPPORTED="1"
K_BASE_VER="5.14"
K_EXP_GENPATCHES_NOUSE="1"
K_FROM_GIT="yes"
ETYPE="sources"
CKV="${PVR/-r/-git}"

# only use this if it's not an _rc/_pre release
[ "${PV/_pre}" == "${PV}" ] && [ "${PV/_rc}" == "${PV}" ] && OKV="${PV}"
inherit kernel-2
detect_version

DESCRIPTION="The very latest -git version of the Linux kernel"
HOMEPAGE="https://www.kernel.org"
SRC_URI="${KERNEL_URI}"

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

K_EXTRAEINFO="This kernel is not supported by Gentoo due to its unstable and
experimental nature. If you have any issues, try a matching vanilla-sources
ebuild -- if the problem is not there, please contact the upstream kernel
developers at https://bugzilla.kernel.org and on the linux-kernel mailing list to
report the problem so it can be fixed in time for the next kernel release."

RDEPEND=""
DEPEND="${RDEPEND}
	>=sys-devel/patch-2.7.5"


PATCHES=(
	# From https://github.com/Maccraft123/Cadmium/tree/master/baseboard/kukui/patches
	${FILESDIR}/drm.patch
	${FILESDIR}/gpu-vsram.patch
	${FILESDIR}/move-gpu-opp-to-3.patch
	${FILESDIR}/mutex-gce-events.patch
	${FILESDIR}/opp-multi-regulator.patch
    ${FILESDIR}/panel-dts-rotation.patch
    ${FILESDIR}/panel-dts-rotation_sku0.patch
    ${FILESDIR}/sound_1.patch
    ${FILESDIR}/sound_2.patch
	# From https://github.com/hexdump0815/linux-mainline-mediatek-mt81xx-kernel/tree/master/misc.cbm/patches/5.13.2
	#${FILESDIR}/mt8183-disable-unsupported-thermal-zones.patch
	${FILESDIR}/mt8183-panel-orientation.patch
	${FILESDIR}/mt8183-silence-some-log-spam.patch
	${FILESDIR}/mt8183-sound-juniper.patch
	# cherry-pick from https://patchwork.kernel.org/project/linux-mediatek
	${FILESDIR}/Add-cpufreq-and-cci-devfreq-for-mt8183-and-SVS-support-fix.patch
	${FILESDIR}/Revert-series-CMDQ-refinement-of-Mediatek-DRM-driver.patch
	${FILESDIR}/v4-media-mtk-vpu-Ensure-alignment-of-8-for-DTCM-buffer.patch
	${FILESDIR}/media-mediatek-support-mdp3-on-mt8183-platform-fix-5.15.patch
	${FILESDIR}/Introducing-an-attribute-to-select-the-time-setting.patch
	#${FILESDIR}/ASoC-mediatek-common-handle-NULL-case-in-suspend-resume-function.patch
	${FILESDIR}/drm-panel-boe-tv101wum-nl6-Support-enabling-a-3.3V-rail.patch
	${FILESDIR}/soc-mediatek-SVS-introduce-MTK-SVS-engine-fix.patch
	${FILESDIR}/media-platform-Add-support-for-Digital-Image-Processing-DIP-on-mt8183-SoC-fix.patch
	${FILESDIR}/media-platform-Add-support-for-Face-Detection-FD-on-mt8183-SoC-fix.patch
	${FILESDIR}/media-media-platform-mtk-isp-Add-Mediatek-ISP-Pass-1-driver-fix.patch
	${FILESDIR}/media-support-Mediatek-sensor-interface-driver-fix.patch
	${FILESDIR}/media-support-Mediatek-sensor-interface-driver-fix-2.patch
	#${FILESDIR}/Fix-the-issues-caused-by-CMDQ-refinement-of-mtk-drm.patch
	

	${FILESDIR}/mailbox-Remove-WARN_ON-for-async_cb.cb-in-cmdq_exec_done.patch
	${FILESDIR}/drm-mediatek-add-dither-6-setting.patch
	#${FILESDIR}/v6-RESEND-1-3-gpu-drm-separate-panel-orientation-property-creating-and-value-setting.patch
	${FILESDIR}/v5-1-3-dt-bindings-mediatek-convert-mtk-jpeg-decoder-encoder-to-yaml.patch
	${FILESDIR}/v4-3-3-arm64-dts-mt8183-add-jpeg-enc-node-for-mt8183.diff
	${FILESDIR}/Clean-up-mediatek-larb-fix-5.15.patch
	${FILESDIR}/v2-dma-buf-remove-restriction-of-IOCTL-DMA_BUF_SET_NAME.patch
	${FILESDIR}/v2-dma-buf-acquire-name-lock-before-read-write-dma_buf.name.patch
	#${FILESDIR}/Add-support-to-the-mmsys-driver-to-be-a-reset-controller-fix.patch
	#${FILESDIR}/Using-component-framework-to-support-multi-hardware-decode.patch
	# 
#	${FILESDIR}/Multigenerational-LRU-Framework.patch
	# various fixes
	${FILESDIR}/fix-v4l2-ioctl.patch
	${FILESDIR}/fix-scp_get_pdev.patch
	${FILESDIR}/add-ov02a10-ov8856.patch
	${FILESDIR}/fix-mt8183-svs.patch
	${FILESDIR}/fix-mt8183-dpi.patch
	${FILESDIR}/fix-mt8183-fssource.patch
	${FILESDIR}/fix-mt8183-mdp-5.15.patch
	${FILESDIR}/fix-mt8183-vcodec.patch
	${FILESDIR}/fix-kukui-sspm.patch
	${FILESDIR}/fix-kukui-gpu.patch
	${FILESDIR}/fix-kukui-pin.patch
	#
	#${FILESDIR}/fix-kukui-snd.patch
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
	einfo "If you use kernel config coming with this ebuild, don't forget to also copy/edit fs-display.conf to /etc/dracut.conf.d/"
	einfo "to make sure proper kernel modules are loaded into initramfs"
	einfo "if you want to cross compile arm64 kernel on amd64 host, follow the https://wiki.gentoo.org/wiki/Cross_build_environment"
	einfo "to setup cross toolchain environment, then create a xmake wrapper like the following, and replace make with xmake in above commands"
	einfo "#!/bin/sh"
	einfo "exec make ARCH='arm64' CROSS_COMPILE='aarch64-unknown-linux-gnu-' INSTALL_MOD_PATH='${SYSROOT}' '$@'"
}
