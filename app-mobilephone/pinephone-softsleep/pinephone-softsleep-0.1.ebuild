# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd git-r3

DESCRIPTION="Test package for 'soft sleep' on PinePhone"
HOMEPAGE="https://gitlab.com/mobian1/devices/pinephone-softsleep.git"
EGIT_REPO_URI="https://gitlab.com/mobian1/devices/pinephone-softsleep.git"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~arm64"
IUSE=""

DEPEND="app-mobilephone/pinephone-modem-scripts"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	insinto /lib/udev/rules.d/
	doins ${S}/20-usb-power.rules
	insinto /etc/systemd/sleep.conf.d/
	doins ${S}/pinephone-softsleep.conf
	exeinto /lib/systemd/system-sleep/
	doexe ${S}/pinephone-suspend-hook.sh
}
