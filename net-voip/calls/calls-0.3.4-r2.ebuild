# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
VALA_USE_DEPEND="vapigen"

inherit vala meson gnome2-utils git-r3 xdg

DESCRIPTION="Phone dialer and call handler"
HOMEPAGE="https://source.puri.sm/Librem5/calls"
#SRC_URI="https://source.puri.sm/Librem5/calls/-/archive/v${PV}/${PN}-v${PV}.tar.gz"
EGIT_REPO_URI="https://source.puri.sm/Librem5/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

if [[ ${PV} != 9999 ]]; then
        #EGIT_COMMIT="tags/v${PV}"
		EGIT_COMMIT="86b3f75cb4895f8826093219ef2e1372d4656dda"
else
        KEYWORDS=""
fi

IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )"

DEPEND="
		dev-libs/feedbackd
		>=gui-libs/libhandy-1.0.0
		dev-libs/folks
		dev-libs/gom
		dev-libs/libpeas
		>=net-misc/modemmanager-1.12.0
		>=media-sound/callaudiod-0.0.5
		gnome-extra/evolution-data-server
		net-libs/sofia-sip
		"
RDEPEND="${DEPEND}"
BDEPEND="
		vala? ( $(vala_depend) )
		dev-util/meson
		dev-libs/gobject-introspection
		dev-util/wayland-scanner
"

PATCHES=(
	"${FILESDIR}/0001-use-at-cmds-to-mute.patch"
)

#S="${WORKDIR}/${PN}-v${PV}"

src_prepare() {
	default
	eapply_user
	use vala && vala_src_prepare
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
