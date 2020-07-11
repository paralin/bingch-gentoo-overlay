# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson udev

DESCRIPTION="Daemon to offer libfprint functionality over D-Bus"
HOMEPAGE="https://fprint.freedesktop.org/"
SRC_URI="http://ppa.launchpad.net/uunicorn/open-fprintd/ubuntu/pool/main/f/fprintd-clients/${PN}_${PV}.orig.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="examples"

RDEPEND="dev-libs/glib:2
	dev-libs/nss
	>=dev-libs/libgusb-0.3.1
	virtual/libusb:1=
	sys-auth/pam_wrapper
	x11-libs/gtk+:3
	x11-libs/pixman
	x11-libs/libX11
	x11-libs/libXv"

DEPEND="${RDEPEND}
	dev-util/gtk-doc"

BDEPEND="virtual/pkgconfig"

PATCHES=( ${FILESDIR}/make-daemon-optional.patch )

S="${WORKDIR}/${PN}-${PV}"

src_configure() {
	local emesonargs=(
		-Ddaemon=false
		-Dpam=true
		--libdir=/usr/$(get_libdir)
	)
	meson_src_configure
}


src_install() {
	meson_src_install
	rm -rf ${D}/usr/share/dbus-1/system.d/net.reactivated.Fprint.conf
	rm -rf ${D}/usr/share/dbus-1/system-services/net.reactivated.Fprint.service
	rm -rf ${D}/lib/systemd
}
