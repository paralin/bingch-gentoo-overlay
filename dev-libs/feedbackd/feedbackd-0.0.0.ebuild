# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
#GNOME2_LA_PUNT="yes"
VALA_USE_DEPEND="vapigen"

inherit vala meson

KEYWORDS="~amd64 ~arm ~arm64 ~x86"

IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )"

if [[ ${PV} == "0.0.0" ]]; then
	MY_PV="v${PV}+git20200726"
	MY_P="${PN}-${MY_PV}"
fi

DESCRIPTION="A daemon to provide haptic feedback on events"
HOMEPAGE="https://source.puri.sm/Librem5/feedbackd"
if [[ ${PV} == 9999 ]]; then
	inherit vala meson git-r3
	EGIT_REPO_URI="https://source.puri.sm/Librem5/feedbackd.git"
	SRC_URI=""
else
	EGIT_REPO_URI=""
	SRC_URI="https://source.puri.sm/Librem5/feedbackd/-/archive/${MY_PV}/${MY_P}.tar.gz"
	S=${WORKDIR}/${MY_P}
fi
LICENSE="LGPL-3"
SLOT="0"

DEPEND="
		gnome-base/dconf
		media-libs/gsound
		dev-libs/json-glib
		virtual/libgudev
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
}
