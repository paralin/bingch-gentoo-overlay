# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
VALA_USE_DEPEND="vapigen"

inherit vala meson

DESCRIPTION="Phone dialer and call handler"
HOMEPAGE="https://source.puri.sm/Librem5/calls"
SRC_URI="https://source.puri.sm/Librem5/calls/-/archive/v${PV}/${PN}-v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~arm ~x86"
IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )"

DEPEND="
		dev-libs/feedbackd
		gui-libs/libhandy
		dev-libs/folks
		dev-libs/gom
		dev-libs/libpeas
		>=net-misc/modemmanager-1.12.0
		vala? ( $(vala_depend) )
		"
RDEPEND="${DEPEND}"
BDEPEND="
		dev-util/meson
		dev-libs/gobject-introspection
"

S="${WORKDIR}/${PN}-v${PV}"

src_prepare() {
	eapply_user
	use vala && vala_src_prepare
#   gnome2_src_prepare
}
