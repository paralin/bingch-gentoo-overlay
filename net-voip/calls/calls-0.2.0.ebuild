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
KEYWORDS="~amd64 ~arm64 ~arm ~x86"

if [[ ${PV} != 9999 ]]; then
        #EGIT_REPO_BRANCH="tags/v${PV}"
		EGIT_COMMIT="f9648e8f634e12161caac00e7d7e63a16c7ccdc4"
else
        KEYWORDS=""
fi

IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )"

DEPEND="
		dev-libs/feedbackd
		gui-libs/libhandy
		dev-libs/folks
		dev-libs/gom
		dev-libs/libpeas
		>=net-misc/modemmanager-1.12.0
		media-sound/callaudiod
		gnome-extra/evolution-data-server
		"
RDEPEND="${DEPEND}"
BDEPEND="
		vala? ( $(vala_depend) )
		dev-util/meson
		dev-libs/gobject-introspection
"

PATCHES=(
	"${FILESDIR}/188.patch"
	#"${FILESDIR}/calll-display.patch"
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
