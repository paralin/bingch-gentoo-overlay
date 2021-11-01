# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit vala meson gnome2-utils git-r3 xdg
EGIT_REPO_URI="https://gitlab.gnome.org/World/Phosh/${PN}.git"

KEYWORDS="~amd64 ~arm64"
if [[ ${PV} != 9999 ]]; then
    #EGIT_COMMIT="tags/v${PV}"
	EGIT_COMMIT="cc74528e0b0a2e985c4592413433daffad38bcae"
else
    KEYWORDS=""
fi

PATCHES=(
	"${FILESDIR}/0001-seat-Don-t-notify-on-key-release.patch"
)

DESCRIPTION="Wlroots based Phone compositor"
HOMEPAGE="https://source.puri.sm/Librem5/phoc"

LICENSE="GPL-3"
SLOT="0"
IUSE="+introspection"

DEPEND="
	dev-libs/glib
	dev-libs/gobject-introspection
	dev-libs/libinput
	gnome-base/gnome-desktop
	!gui-libs/wlroots
	x11-libs/xcb-util
	x11-libs/xcb-util-wm
	x11-wm/mutter
"
RDEPEND="${DEPEND}"
BDEPEND="
		dev-util/ctags
		x11-base/xorg-server
		dev-util/meson
		virtual/pkgconfig
"

src_unpack() {
	default
	git-r3_fetch
	git-r3_checkout
}

src_prepare() {
	default
	eapply_user
	cd subprojects/wlroots
	eapply ${FILESDIR}/xcursor-fix-false-positive-stringop-truncation.diff
}

src_configure() {
	local emesonargs=(
		-Ddefault_library=shared
		-Dtests=false
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	dobin ${S}/helpers/scale-to-fit
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
