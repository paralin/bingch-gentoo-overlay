# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson gnome2-utils xdg

DESCRIPTION="Virtual keyboard supporting Wayland, built primarily for the Librem 5 phone"
HOMEPAGE="https://source.puri.sm/Librem5/squeekboard"
SRC_URI="https://source.puri.sm/Librem5/squeekboard/-/archive/v${PV}/${PN}-v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64 ~arm"
IUSE=""

DEPEND="${PYTHON_DEPS}
	x11-libs/gtk+
	dev-libs/feedbackd
	gnome-base/gnome-desktop
	media-fonts/noto-emoji
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
	dev-util/intltool
	virtual/rust
	dev-util/gtk-doc
"
S="${WORKDIR}/${PN}-v${PV}"

src_install() {
	meson_src_install
	insinto /usr/bin
	doins "${S}/tools/squeekboard-restyled"
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
