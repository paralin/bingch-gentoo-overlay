# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3
DESCRIPTION="Lightweight On-Screen-Keyboard based on SDL2"
HOMEPAGE="https://gitlab.com/postmarketOS/osk-sdl.git"
EGIT_REPO_URI="https://gitlab.com/postmarketOS/osk-sdl.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm64"

if [[ ${PV} != 9999 ]]; then
        EGIT_REPO_BRANCH="tags/v${PV}"
else
        KEYWORDS=""
fi

DEPEND="sys-fs/cryptsetup
		media-libs/libsdl2[kms,tslib]
		media-libs/sdl2-ttf
		media-fonts/dejavu
		sys-kernel/dracut
		app-portage/gentoolkit

"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	default
	sed -e s/ttf-dejavu/dejavu/ -i osk.conf
}

src_install() {
	dobin bin/osk-sdl
	insinto /etc
	doins osk.conf
	insinto /usr/lib/dracut/modules.d/91osk-sdl
	doins ${FILESDIR}/module-setup.sh
	doins ${FILESDIR}/osk-sdl.sh
}
