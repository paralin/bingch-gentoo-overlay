# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
#GNOME2_LA_PUNT="yes"
VALA_USE_DEPEND="vapigen"

inherit vala meson udev

KEYWORDS="~amd64 ~arm ~arm64 ~x86"

IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )"

if [[ ${PV} == "0.0.0" ]]; then
	MY_PV="${PV}+git20210426"
	MY_P="${PN}-${MY_PV}"
	MY_COMMIT="b45468080eee851da500613ecedd709639b6d769"
	MY_THEME_COMMIT="1602d415aed30b1a67c0ff270551230725b8ef92"
fi

DESCRIPTION="A daemon to provide haptic feedback on events"
HOMEPAGE="https://source.puri.sm/Librem5/feedbackd"
if [[ ${PV} == 9999 ]]; then
	inherit vala meson udev git-r3
	EGIT_REPO_URI="https://source.puri.sm/Librem5/feedbackd.git"
	SRC_URI=""
else
	EGIT_REPO_URI=""
	#SRC_URI="https://source.puri.sm/Librem5/feedbackd/-/archive/${MY_PV}/${MY_P}.tar.gz"
	SRC_URI="
	https://source.puri.sm/Librem5/feedbackd/-/archive/${MY_COMMIT}/${MY_COMMIT}.tar.gz
	https://source.puri.sm/Librem5/feedbackd-device-themes/-/archive/${MY_THEME_COMMIT}/feedbackd-device-themes-${MY_THEME_COMMIT}.tar.gz
	"

	S=${WORKDIR}/${PN}-${MY_COMMIT}
fi
LICENSE="LGPL-3"
SLOT="0"

DEPEND="
		gnome-base/dconf
		media-libs/gsound
		dev-libs/json-glib
		dev-libs/libgudev
"
RDEPEND="${DEPEND}"
BDEPEND="
		dev-libs/gobject-introspection
		dev-util/meson
		virtual/pkgconfig
		vala? ( $(vala_depend) )
"

PATCHES=(
#	${FILESDIR}/55.patch
)

src_prepare() {
	default
	eapply_user
	use vala && vala_src_prepare
	sed -i 's/-G feedbackd/-G video/g' ${S}/debian/feedbackd.udev
}

src_install() {
	default
	meson_src_install
	insinto /usr/share/feedbackd/themes
	doins ${WORKDIR}/feedbackd-device-themes-${MY_THEME_COMMIT}/data/*.json
	udev_newrules ${S}/debian/feedbackd.udev 90-feedbackd.rules
}
