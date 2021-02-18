# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3 systemd

DESCRIPTION="Daemon for managing the Quectel EG25 modem"
HOMEPAGE="https://gitlab.com/mobian1/devices/eg25-manager"


KEYWORDS="~arm64"

EGIT_REPO_URI="${HOMEPAGE}.git"

if [[ ${PV} != 9999 ]]; then
	EGIT_COMMIT="3bb6e15de0e14c08135c82dd71d9774ad02ffc1b"
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

PATCHES="${FILESDIR}/6.patch
		${FILESDIR}/0001-suspend-add-boot-timer.patch
"

src_install() {
	meson_src_install
	systemd_dounit "${FILESDIR}"/eg25-manager.service
}

pkg_postinst() {
	systemd_reenable --all eg25-manager
}

