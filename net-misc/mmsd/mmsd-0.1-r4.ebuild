# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 systemd meson

DESCRIPTION="Daemon for transmitting and receiving MMS"
HOMEPAGE="https://source.puri.sm/kop316/mmsd"
EGIT_REPO_URI="https://source.puri.sm/kop316/mmsd.git"
#EGIT_BRANCH="head"
EGIT_COMMIT="5ce01f38"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~arm64"

RDEPEND="net-misc/modemmanager
	>=dev-libs/glib-2.66.7
	sys-apps/dbus"
DEPEND="${RDEPEND}"

src_install() {
	meson_src_install
	systemd_douserunit "${FILESDIR}"/mmsd.service
}

pkg_postinst() {
	systemd_reenable --all mmsd
}
