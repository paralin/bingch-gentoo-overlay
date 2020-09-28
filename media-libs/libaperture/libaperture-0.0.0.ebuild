# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
VALA_USE_DEPEND="vapigen"

inherit meson gnome2-utils vala
DESCRIPTION="A camera library for GTK3"
HOMEPAGE="https://gitlab.gnome.org/jwestman/libaperture"
_commit="2191fbedcbb1936600e58aca6aa84d2333e447c7"
SRC_URI="https://gitlab.gnome.org/jwestman/libaperture/-/archive/$_commit/libaperture-$_commit.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64 ~arm"
IUSE="+introspection +vala"

DEPEND="media-libs/gstreamer
		media-libs/gst-plugins-base
		vala? ( $(vala_depend) )
"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=("${FILESDIR}/0001-test-barcodes-remove-failing-test.patch"
		"${FILESDIR}/0002-aperture-viewfinder-rotate-picture-90-right.patch"
)

S=${WORKDIR}/${PN}-$_commit

src_prepare() {
	default
	eapply_user
	use vala && vala_src_prepare
}
