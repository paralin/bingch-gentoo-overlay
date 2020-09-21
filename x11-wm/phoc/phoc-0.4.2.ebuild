# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
#GNOME2_LA_PUNT="yes"
VALA_USE_DEPEND="vapigen"

if [[ ${PV} == 9999 ]]; then
    inherit vala meson gnome.org gnome2-utils git-r3
    EGIT_REPO_URI="https://source.puri.sm/Librem5/phoc.git"
    SRC_URI=''
	KEYWORDS=""
else
	inherit vala meson gnome.org gnome2-utils
	MY_P="${PN}-v${PV}"
    EGIT_REPO_URI=""
    SRC_URI="https://source.puri.sm/Librem5/${PN}/-/archive/v${PV}/${MY_P}.tar.gz"
    S=${WORKDIR}/${MY_P}
	KEYWORDS="~amd64 ~x86 ~arm ~arm64"
fi

DESCRIPTION="Wlroots based Phone compositor"
HOMEPAGE="https://source.puri.sm/Librem5/phoc"

LICENSE="GPL-3"
SLOT="0"
IUSE="+vala +introspection"
REQUIRED_USE="vala? ( introspection )"

DEPEND="
	dev-libs/glib
	gui-libs/wlroots
	gui-libs/libhandy
	vala? ( $(vala_depend) )
"
RDEPEND="${DEPEND}"
BDEPEND="
		dev-util/ctags
		x11-base/xorg-server
		dev-libs/gobject-introspection
		dev-util/meson
		dev-util/pkgconfig
"
src_prepare() {
	eapply_user
	use vala && vala_src_prepare
}

src_configure() {
	local emesonargs=(
		-Dembed-wlroots=disabled
		-Ddefault_library=shared
	)
	meson_src_configure
}
