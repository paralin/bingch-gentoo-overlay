# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Firmware files for RTL8723BS/CS"
#HOMEPAGE="https://github.com/anarsoul/rtl8723bt-firmware"
#EGIT_REPO_URI="https://github.com/anarsoul/rtl8723bt-firmware.git"
HOMEPAGE="https://xff.cz/git/linux-firmware"
EGIT_REPO_URI="https://megous.com/git/linux-firmware"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64 ~arm"
IUSE="rtlwifi"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	default
	mkdir -p ${D}/lib/firmware/
	cp -pr ${S}/rtl_bt ${D}/lib/firmware/
}
