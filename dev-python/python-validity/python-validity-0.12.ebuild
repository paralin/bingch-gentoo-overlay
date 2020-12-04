# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

#inherit python-r1
DISTUTILS_USE_SETUPTOOLS=no

inherit distutils-r1

DESCRIPTION="Validity fingerprint sensor library"
HOMEPAGE="https://github.com/uunicorn/python-validity"
SRC_URI="http://ppa.launchpad.net/uunicorn/open-fprintd/ubuntu/pool/main/p/python-validity/${PN}_${PV}~ppa1.tar.xz"

LICENSE="LGPL-2.1+"
SLOT="3"
KEYWORDS="~amd64"
IUSE="+open-fprintd"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	open-fprintd? ( >=dev-python/open-fprintd-0.4 )
	>=dev-python/cryptography-2.8-r1
	>=dev-python/pyusb-1.0.2
	sys-apps/dbus
	app-arch/innoextract
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"
S="${WORKDIR}/${PN}"

PATCHES=(
	# Fix python3-validity.service suspend issue
	"${FILESDIR}/always-restart.patch"
)

python_prepare_all() {
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
	if use open-fprintd; then
		insinto /lib/systemd/system/
		doins "${S}/debian/python3-validity.service"
		insinto /lib/udev/rules.d/
		newins "${S}/debian/python3-validity.udev" 60-python3-validity.rules
	fi
}

pkg_postinst() {
	ewarn "Downloading and extracting validity sensor firmware..."
	validity-sensors-firmware || true
	ewarn "Pairing validity sensor ..."
	python -c "from validitysensor.init import open; open()"
	if use open-fprintd; then
		systemctl daemon-reload || true
		udevadm control --reload-rules || true
		udevadm trigger || true
	fi
}

pkg_prerm() {
	if use open-fprintd; then
		systemctl stop 'python3-validity*'
	fi
}
