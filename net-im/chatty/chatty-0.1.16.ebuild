# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson gnome2-utils xdg

DESCRIPTION="Messaging client"
HOMEPAGE="https://source.puri.sm/Librem5/chatty"
SRC_URI="https://source.puri.sm/Librem5/chatty/-/archive/v${PV}/${PN}-v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64 ~arm"
IUSE=""

DEPEND="gnome-extra/evolution-data-server
		dev-libs/feedbackd
		gui-libs/libhandy
		x11-plugins/purple-mm-sms
		x11-libs/gtk+:3
"
RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}/${PN}-v${PV}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
