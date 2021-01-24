# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_OPTIONAL=1
PYTHON_COMPAT=( python3_{6..9} )

inherit distutils-r1 scons-utils toolchain-funcs udev

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://gitlab.com/gpsd/gpsd.git"
	inherit git-r3
else
	SRC_URI="mirror://nongnu/${PN}/${P}.tar.xz"
	KEYWORDS="amd64 arm ~arm64 ~ppc ~ppc64 ~sparc x86"
fi

DESCRIPTION="GPS daemon and library for USB/serial GPS devices and GPS/mapping clients"
HOMEPAGE="https://gpsd.io/"

LICENSE="BSD GPL-2"
SLOT="0/27"

IUSE="bluetooth +cxx dbus debug ipv6 latency-timing ncurses ntp python qt5 +shm +sockets static test udev usb X"
REQUIRED_USE="X? ( python )
	python? ( ${PYTHON_REQUIRED_USE} )
	qt5? ( cxx )"
RESTRICT="!test? ( test )"

RDEPEND="
	acct-user/gpsd
	>=net-misc/pps-tools-0.0.20120407
	bluetooth? ( net-wireless/bluez )
	dbus? (
		sys-apps/dbus
		dev-libs/dbus-glib
	)
	ncurses? ( sys-libs/ncurses:= )
	ntp? ( || (
		net-misc/ntp
		net-misc/ntpsec
		net-misc/chrony
	) )
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtnetwork:5
	)
	python? ( ${PYTHON_DEPS} )
	dev-python/pyserial
	dev-python/matplotlib
	usb? ( virtual/libusb:1 )
	X? ( dev-python/pygobject:3[cairo,${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}
	test? ( sys-devel/bc )"
BDEPEND="virtual/pkgconfig
	$(python_gen_any_dep ">=dev-util/scons-2.3.0[\${PYTHON_USEDEP}]")"

# xml packages are for man page generation
if [[ ${PV} == *9999* ]] ; then
	DEPEND+="
		app-text/xmlto
		=app-text/docbook-xml-dtd-4.1*"
fi

PATCHES=(
#	"${FILESDIR}"/${PN}-3.21-scons_conditional_python_scripts.patch
)

src_prepare() {
	default
	python_setup
}

src_configure() {
	scons_opts=(
		prefix="${EPREFIX}/usr"
		libdir="\$prefix/$(get_libdir)"
		udevdir="$(get_udevdir)"
		rundir="/run"
		chrpath=False
		gpsd_user=gpsd
		gpsd_group=dialout
		nostrip=True
		manbuild=False
		shared=$(usex !static True False)
		bluez=$(usex bluetooth)
		libgpsmm=$(usex cxx)
		clientdebug=$(usex debug)
		dbus_export=$(usex dbus)
		ipv6=$(usex ipv6)
		timing=$(usex latency-timing)
		ncurses=$(usex ncurses)
		ntpshm=$(usex ntp)
		pps=$(usex ntp)
		python=$(usex python)
		# force a predictable python libdir because lib vs. lib64 usage differs
		# from 3.5 to 3.6+
		$(usex python python_libdir="${EPREFIX}"/python-discard "")
		qt=$(usex qt5)
		shm_export=$(usex shm)
		socket_export=$(usex sockets)
		usb=$(usex usb)
		xgps=$(usex X)
	)

	use qt5 && scons_opts+=( qt_versioned=5 )

	# enable specified protocols
	local protocol
	for protocol in ${GPSD_PROTOCOLS[@]} ; do
		scons_opts+=( ${protocol}=$(usex gpsd_protocols_${protocol}) )
	done
}

src_compile() {
	export CHRPATH=
	tc-export CC CXX PKG_CONFIG
	export SHLINKFLAGS=${LDFLAGS} LINKFLAGS=${LDFLAGS}
	escons "${scons_opts[@]}"
	escons build

}

src_install() {
	DESTDIR="${D}" escons install "${scons_opts[@]}" $(usex udev udev-install "")

	newconfd "${FILESDIR}"/gpsd.conf-2 gpsd
	newinitd "${FILESDIR}"/gpsd.init-2 gpsd

	# Cleanup bad alt copy due to Scons
	if use python ; then
		rm -rf "${ED}"/python-discard/gps* || die
		find "${ED}"/python-discard/ -type d -delete || die
	fi
}
