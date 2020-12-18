# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
UNIPATCH_STRICTORDER="yes"
K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
K_NOUSEPR="yes"
K_SECURITY_UNSUPPORTED="1"
K_BASE_VER="5.9"
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
MEGI_PATCH_URI="https://xff.cz/kernels/5.10/patches/all.patch"
SRC_URI="${KERNEL_URI}
	${MEGI_PATCH_URI} -> all-5.10.patch"

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

K_EXTRAEINFO="This kernel is not supported by Gentoo due to its unstable and
experimental nature. If you have any issues, try a matching vanilla-sources
ebuild -- if the problem is not there, please contact the upstream kernel
developers at https://bugzilla.kernel.org and on the linux-kernel mailing list to
report the problem so it can be fixed in time for the next kernel release."

PATCHES=(
    ${DISTDIR}/all-5.10.patch
    #${FILESDIR}/wifi-power-saving.patch
    ${FILESDIR}/panic-led.patch
    ${FILESDIR}/enable-hdmi-output-pinetab.patch
    ${FILESDIR}/improve-brightness.patch
    ${FILESDIR}/enable-jack-detection-pinetab.patch
    ${FILESDIR}/pinetab-bluetooth.patch
    ${FILESDIR}/pinetab-accelerometer.patch
    ${FILESDIR}/camera-autofocus.patch
    ${FILESDIR}/media-ov5640-dont-break-when-firmware-for-autofocus-isnt-loaded.patch
    ${FILESDIR}/camera-added-bggr-bayer-mode.patch
    #${FILESDIR}/drm-lima-add-LIMA_BO_FLAG_FORCE_VA.patch
    ${FILESDIR}/0002-Bluetooth-Fix-LL-PRivacy-BLE-device-fails-to-connect.patch
    ${FILESDIR}/0003-Bluetooth-Fix-attempting-to-set-RPA-timeout-when-unsupported.patch
)
RDEPEND=""
DEPEND="${RDEPEND}
	>=sys-devel/patch-2.7.5"

src_prepare() {
	default
	eapply_user
}

pkg_postinst() {
	postinst_sources
}
