# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
VALA_USE_DEPEND="vapigen"

inherit meson systemd vala

DESCRIPTION="A simple daemon to monitor thermal zones and cooling devices"
HOMEPAGE="https://source.puri.sm/Librem5/gtherm"
SRC_URI="https://source.puri.sm/Librem5/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64 ~arm"
IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )"

DEPEND="vala? ( $(vala_depend) )
		dev-libs/gobject-introspection
"
RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}/${PN}-v${PV}

src_prepare() {
	eapply_user
	use vala && vala_src_prepare
}

src_install() {
	meson_src_install
	systemd_newuserunit "${S}"/debian/gthd.user.service "gthd.service"
}
