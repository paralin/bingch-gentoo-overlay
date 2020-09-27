# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Firmware files for ANX7688"
HOMEPAGE="https://xff.cz/git/linux-firmware"
EGIT_REPO_URI="https://megous.com/git/linux-firmware"

LICENSE="anx7688"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64 ~arm"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	insinto /lib/firmware
	doins anx7688-fw.bin
}

