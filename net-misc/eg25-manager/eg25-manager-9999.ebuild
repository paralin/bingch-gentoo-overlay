# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3 systemd

DESCRIPTION="Daemon for managing the Quectel EG25 modem"
HOMEPAGE="https://gitlab.com/mobian1/devices/eg25-manager"


KEYWORDS="~amd64 ~arm ~arm64 ~x86"

EGIT_REPO_URI="${HOMEPAGE}.git"

if [[ ${PV} != 9999 ]]; then
	EGIT_REPO_BRANCH="tags/${PV}"
else
	KEYWORDS=""
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
		dev-libs/libgpiod
		virtual/libusb:1
		net-misc/modemmanager
		"
RDEPEND="${DEPEND}"

src_install() {
	meson_src_install
	systemd_dounit "${FILESDIR}"/eg25-manager.service
}
