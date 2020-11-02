# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3
DESCRIPTION=""
HOMEPAGE="https://gitlab.com/wczyz/osk-sdl.git"
EGIT_REPO_URI="https://gitlab.com/wczyz/osk-sdl.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm ~arm64"

DEPEND="media-libs/libsdl2
		media-fonts/dejavu
		media-libs/sdl2-ttf"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=("$FILESDIR/fontpath.patch")

src_install() {
	dobin bin/osk-sdl
	insinto etc
	doins osk.conf
}
