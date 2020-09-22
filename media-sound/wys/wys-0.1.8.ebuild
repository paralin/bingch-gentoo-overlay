# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson systemd

DESCRIPTION="WYS audio manage for Pinephone"
HOMEPAGE="https://source.puri.sm/Librem5/wys"
SRC_URI="https://source.puri.sm/Librem5/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
IUSE=""

DEPEND="net-misc/modemmanager
		media-sound/pulseaudio
"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/meson"

S="${WORKDIR}/${PN}-v${PV}"

src_install() {
	default
	meson_src_install
	systemd_newuserunit "${S}"/debian/wys.user-service 'wys.service'
}
