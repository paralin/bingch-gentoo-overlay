# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson gnome2-utils xdg git-r3

DESCRIPTION="Virtual keyboard supporting Wayland, built primarily for the Librem 5 phone"
HOMEPAGE="https://source.puri.sm/Librem5/squeekboard"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

EGIT_REPO_URI="https://source.puri.sm/Librem5/${PN}.git"
if [[ ${PV} != 9999 ]]; then
    #EGIT_COMMIT="tags/v${PV}"
    EGIT_COMMIT="bffd212e102bf71a94c599aac0359a8d30d19008"
else
    KEYWORDS=""
fi

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
#S="${WORKDIR}/${PN}-v${PV}"

#src_install() {
#	meson_src_install
#	insinto /usr/bin
#	doins "${S}/tools/squeekboard-restyled"
#}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
