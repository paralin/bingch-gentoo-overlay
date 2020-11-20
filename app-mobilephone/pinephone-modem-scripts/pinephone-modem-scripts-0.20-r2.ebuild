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

DEPEND="net-dialup/atinout"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	udev_dorules ${S}/*.rules 
	dosbin ${S}/*.sh
	systemd_dounit ${S}/*.service
	systemd_dounit ${FILESDIR}/*.path
}

pkg_postinst() {
	systemd_enable_service pinephone-modem-scripts.pinephone-modem.path
}
