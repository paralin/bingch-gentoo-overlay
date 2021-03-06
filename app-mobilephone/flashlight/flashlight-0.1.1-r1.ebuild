# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 gnome2-utils meson udev

DESCRIPTION="It's a flashlight, what do you expect?"
HOMEPAGE="https://gitlab.com/a-wai/flashlight.git"
EGIT_REPO_URI="https://gitlab.com/a-wai/flashlight.git"
#EGIT_COMMIT=""
LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

src_install() {
	meson_src_install
	udev_dorules "${FILESDIR}/60-flashlight.rules"
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
