# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd git-r3

DESCRIPTION="Modem scripts for the PinePhone"
HOMEPAGE="https://gitlab.com/a-wai/pinephone-modem-script"
EGIT_REPO_URI="https://gitlab.com/a-wai/pinephone-modem-scripts.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm64"
IUSE=""

DEPEND="net-misc/modemmanager"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	dosbin modem-scripts/*
	systemd_dounit ${S}/debian/*.service

}
