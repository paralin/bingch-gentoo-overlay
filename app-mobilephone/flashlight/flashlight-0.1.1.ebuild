# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson gnome2-utils udev

DESCRIPTION="It's a flashlight, what do you expect?"
HOMEPAGE="https://gitlab.com/a-wai/flashlight.git"
EGIT_REPO_URI="https://gitlab.com/a-wai/flashlight.git"
EGIT_COMMIT="4ecaa952b676be8ae808e7cc8b12b59342c5e1f5"
LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64 ~arm"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	meson_src_install
	udev_dorules "${FILESDIR}/90-flashlight.rules"
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
