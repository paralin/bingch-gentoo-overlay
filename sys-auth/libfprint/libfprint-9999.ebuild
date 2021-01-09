# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit udev

DESCRIPTION="library to add support for consumer fingerprint readers"
HOMEPAGE="https://cgit.freedesktop.org/libfprint/libfprint/ https://github.com/freedesktop/libfprint https://gitlab.freedesktop.org/libfprint/libfprint"
if [[ ${PV} == 9999 ]]; then
    inherit git-r3 meson

	EGIT_REPO_URI="https://gitlab.freedesktop.org/3v1n0/libfprint.git"
    EGIT_BRANCH="tod"
    KEYWORDS=""
else
	SRC_URI="https://gitlab.freedesktop.org/libfprint/libfprint/-/archive/v${PV}/${PN}-v${PV}.tar.gz -> ${P}.tar.gz"
    KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
	S="${WORKDIR}/${PN}-v${PV}"
fi

LICENSE="LGPL-2.1"
SLOT="2"
IUSE="examples +introspection"

RDEPEND="dev-libs/glib:2
	dev-libs/nss
	>=dev-libs/libgusb-0.3.1
	virtual/libusb:1=
	x11-libs/gtk+:3
	x11-libs/pixman
	x11-libs/libX11
	x11-libs/libXv
	!>=${CATEGORY}/${PN}-1.90:0"

DEPEND="${RDEPEND}"

BDEPEND="dev-util/gtk-doc
	virtual/pkgconfig
	introspection? ( dev-libs/gobject-introspection )"

PATCHES=( ${FILESDIR}/${PN}-0.8.2-fix-implicit-declaration.patch
		#	${FILESDIR}/009a.patch
)

#S="${WORKDIR}/${PN}-v${PV}"
#src_prepare(){
	#epatch ${FILESDIR}/009a-hrenod.patch
	#epatch ${FILESDIR}/add_debug.patch
	#./autogen.sh
	#make distclean
#}

src_configure() {
	local emesonargs=(
			-Ddoc=false
			$(meson_use examples gtk-examples)
			$(meson_use introspection)
			-Ddrivers=all
			-Dudev_rules=true
			-Dudev_rules_dir=$(get_udevdir)/rules.d
			--libdir=/usr/$(get_libdir)
		)
	meson_src_configure
}

src_install() {
	meson_src_install
	exeinto  /usr/bin
	doexe ${BUILD_DIR}/examples/{enroll,manage-prints,verify}
}
