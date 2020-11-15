# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson systemd

DESCRIPTION="WYS audio manage for Pinephone"
HOMEPAGE="https://source.puri.sm/Librem5/wys"
SRC_URI="https://source.puri.sm/Librem5/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz"

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

PATCHES=("${FILESDIR}/0002-Simplify-daemon-to-only-switch-card-profiles.patch")

src_prepare() {
	default
	sed -i -e "s|0.1.7|${PV}|g" meson.build
}

src_install() {
	default
	meson_src_install
	systemd_newuserunit "${S}"/debian/wys.user-service 'wys.service'
}

pkg_postinst() {
	systemd_enable_service --global wys
}
