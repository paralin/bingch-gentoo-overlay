# Copyright 1999-2021 Gentoo Authors
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
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="rtlwifi"

src_install() {
	default
	mkdir -p "${ED}"/lib/firmware/
	cp -pr "${S}"/rtl_bt "${ED}"/lib/firmware/
	cd "${ED}"/lib/firmware/rtl_bt
	ln -s rtl8723cs_xx_config-pinephone.bin rtl8723cs_xx_config.bin
}
