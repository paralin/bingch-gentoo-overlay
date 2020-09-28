# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
VALA_USE_DEPEND="vapigen"

if [[ ${PV} == 9999 ]]; then
    inherit vala meson gnome.org gnome2-utils git-r3 xdg
    EGIT_REPO_URI="https://source.puri.sm/Librem5/phoc.git"
    SRC_URI=''
	KEYWORDS=""
else
	inherit vala meson gnome.org gnome2-utils xdg
	MY_P="${PN}-v${PV}"
    EGIT_REPO_URI=""
    SRC_URI="https://source.puri.sm/Librem5/${PN}/-/archive/v${PV}/${MY_P}.tar.gz"
    S=${WORKDIR}/${MY_P}
	KEYWORDS="~amd64 ~x86 ~arm ~arm64"
fi

PATCHES=(
	"${FILESDIR}/0001-seat-Don-t-notify-on-key-release.patch"
	"${FILESDIR}/0002-seat-inhibit-touch-events-when-in-power-save-mode-or.patch"
)

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
	default
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

src_install() {
	meson_src_install
	insinto /etc/dconf/profile/user
	doins 01-phoc-scaling
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}

