# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Firmware files for RTL8723BS and RTL8723CS"
HOMEPAGE="https://github.com/anarsoul/rtl8723bt-firmware"
EGIT_REPO_URI="https://github.com/anarsoul/rtl8723bt-firmware.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64 ~arm"
IUSE="rtlwifi"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	default
	rm -f ${D}/lib/firmware/Makefile
	cd ${D}/lib/firmware/rtl_bt/
	ln -s rtl8723cs_xx_config.bin rtl8723cs_xx_config-pinephone.bin 
}
