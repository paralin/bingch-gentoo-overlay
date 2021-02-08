# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3
DESCRIPTION="Lightweight On-Screen-Keyboard based on SDL2"
HOMEPAGE="https://gitlab.com/postmarketOS/osk-sdl.git"
EGIT_REPO_URI="https://gitlab.com/postmarketOS/osk-sdl.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="test"

if [[ ${PV} != 9999 ]]; then
        EGIT_COMMIT="tags/${PV}"
else
        KEYWORDS=""
		inherit git-r3 meson
fi

DEPEND="sys-fs/cryptsetup
		media-libs/libsdl2[kms,haptic]
		media-libs/sdl2-ttf
		media-fonts/dejavu
		sys-kernel/dracut
		app-portage/gentoolkit
"

RDEPEND="${DEPEND}"
BDEPEND="app-text/scdoc
		test? ( x11-misc/xvfb-run )
"

src_prepare() {
	default
	sed -e s/ttf-dejavu/dejavu/ -i osk.conf
}

src_install() {
	meson_src_install
	insinto /etc
	doins osk.conf
	insinto /etc/dracut.conf.d/
	doins ${FILESDIR}/osk-sdl-pp.conf
	insinto /usr/lib/dracut/modules.d/50osk-sdl
	doins ${FILESDIR}/osk-sdl-pp.path
	doins ${FILESDIR}/osk-sdl-pp.service
	exeinto /usr/lib/dracut/modules.d/50osk-sdl
	doexe ${FILESDIR}/module-setup.sh
	doexe ${FILESDIR}/osk-sdl.sh
}

pkg_postinst() {
	einfo "For more info on how to test osk-sdl, and how to report problems, see:"
	einfo "${HOMEPAGE}"
	einfo "To use osk-sdl to unlock encrypted root at bootime, check osk-sdl-pp.conf in /etc/dracut.conf.d"
	einfo "and add these boot option 'root=/dev/mapper/root cryptroot=/dev/path/to/encrypted_partition' "
}
