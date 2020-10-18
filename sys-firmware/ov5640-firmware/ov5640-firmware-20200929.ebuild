# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Firmware files for ov5640"
HOMEPAGE="https://github.com/pmsourcedump/ov5640"
EGIT_REPO_URI="https://github.com/pmsourcedump/ov5640"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64 ~arm"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	default
	mkdir -p ${D}/lib/firmware/
	cp ${S}/ov5640_af.bin ${D}/lib/firmware/
}
