# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
VALA_USE_DEPEND="vapigen"

inherit meson git-r3 gnome2-utils vala xdg

DESCRIPTION="Take photos and videos on your computer or smartphone"
HOMEPAGE="https://gitlab.gnome.org/jwestman/camera"
EGIT_REPO_URI="https://gitlab.gnome.org/jwestman/camera.git"
EGIT_COMMIT=e7a1bc9b35027ef2c43c75a4bb73367c91100024

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64 ~arm"
IUSE="+introspection +vala"

DEPEND="media-libs/libaperture
		gui-libs/libhandy:1.0
		media-plugins/gst-plugins-gtk
		media-libs/gst-plugins-good
		media-libs/gst-plugins-bad
		vala? ( $(vala_depend) )
"
RDEPEND="${DEPEND}"
BDEPEND=""

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

