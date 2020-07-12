# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

#inherit python-r1
DISTUTILS_USE_SETUPTOOLS=no

inherit meson pam systemd

DESCRIPTION="D-Bus service to access fingerprint readers"
HOMEPAGE="https://cgit.freedesktop.org/libfprint/fprintd/"
SRC_URI="https://gitlab.freedesktop.org/libfprint/fprintd/-/archive/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc pam daemon"

RDEPEND="
	dev-libs/dbus-glib
	dev-libs/glib:2
	daemon? ( sys-auth/libfprint dev-python/dbusmock )
	sys-auth/polkit
	pam? ( sys-libs/pam )
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc
	dev-util/gtk-doc-am
	dev-util/intltool
	doc? ( dev-libs/libxml2 dev-libs/libxslt )
"


PATCHES=( ${FILESDIR}/make-daemon-optional.patch )

src_prepare() {
	default

	sed -i 's#@localstatedir@/lib/fprint#@localstatedir@/fprint#g' data/fprintd.service.in || die "sed failed"
	#meson_src_prepare
}

src_configure() {
local emesonargs=(
	-Dgtk_doc=$(usex doc true false)
	-Dpam=$(usex pam true false)
	-Ddaemon=$(usex daemon true false)
	--libdir=/usr/$(get_libdir)
	)
	meson_src_configure
}

src_install() {
	meson_src_install

	if ! use daemon; then 
		rm -rf ${D}/usr/share/dbus-1/system.d/net.reactivated.Fprint.conf
		rm -rf ${D}/usr/share/dbus-1/system-services/net.reactivated.Fprint.service
		rm -rf ${D}/lib/systemd
	fi
}

pkg_postinst() {
	elog "Please take a look at README.pam_fprintd for integration docs."
}
