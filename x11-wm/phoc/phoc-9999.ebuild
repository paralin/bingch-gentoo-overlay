# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
#GNOME2_LA_PUNT="yes"
VALA_USE_DEPEND="vapigen"

if [[ ${PV} == 9999 ]]; then
    inherit vala meson git-r3
    EGIT_REPO_URI="https://source.puri.sm/Librem5/phoc.git"
    SRC_URI=''
else
	inherit vala meson
	MY_P="${PN}-v${PV}"
    EGIT_REPO_URI=""
    SRC_URI="https://source.puri.sm/Librem5/${PN}/-/archive/v${PV}/${MY_P}.tar.gz"
    S=${WORKDIR}/${MY_P}
fi

DESCRIPTION="Wlroots based Phone compositor"
HOMEPAGE="https://source.puri.sm/Librem5/phoc"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="+vala +introspection"
REQUIRED_USE="vala? ( introspection )"

DEPEND="
	x11-wm/mutter
	gui-libs/wlroots
	gui-libs/libhandy
	vala? ( $(vala_depend) )
"
RDEPEND="${DEPEND}"
BDEPEND="
		dev-libs/gobject-introspection
		dev-util/meson
		dev-util/pkgconfig
"
src_prepare() {
	eapply_user
	use vala && vala_src_prepare
#	gnome2_src_prepare
}

