# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Purple SMS plugin using ModemManager"
HOMEPAGE="https://source.puri.sm/Librem5/purple-mm-sms"
SRC_URI="https://source.puri.sm/Librem5/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64 ~arm"
IUSE=""

DEPEND="net-misc/modemmanager
		net-im/pidgin
"

RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}/${PN}-v${PV}
