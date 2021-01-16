# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit udev systemd git-r3

DESCRIPTION="Modem scripts for the PinePhone"
HOMEPAGE="https://gitlab.manjaro.org/manjaro-arm/packages/community/phosh/pinephone-modem-scripts.git"
EGIT_REPO_URI="https://gitlab.manjaro.org/manjaro-arm/packages/community/phosh/pinephone-modem-scripts.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm64"
IUSE=""

DEPEND="net-dialup/atinout
		sci-geosciences/gpsd
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	udev_dorules ${S}/*.rules
	dosbin ${S}/pinephone-modem-stop.sh
	dosbin ${S}/pinephone-modem-start.sh
	dosbin ${S}/pinephone-modem-setup.sh
	exeinto /etc/gpsd/device-hook
	doexe ${S}/gpsd_device-hook.sh
	systemd_dounit ${S}/*.service
	systemd_dounit ${FILESDIR}/*.path
}

pkg_postinst() {
	# ln gpsdctl to /usr/bin
	[ -f /usr/bin/gpsdctl ] || ln -s /usr/sbin/gpsdctl /usr/bin/gpsdctl
	systemctl enable pinephone-modem-scripts.pinephone-modem.path
	systemctl enable gpsd-pinephone.path
}
