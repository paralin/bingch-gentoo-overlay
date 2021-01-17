# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1 systemd

DESCRIPTION="test/control application for the ofono daemon"
HOMEPAGE="https://git.sr.ht/~martijnbraam/ofonoctl"
SRC_URI="https://git.sr.ht/~martijnbraam/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~arm ~x86"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
		dev-python/tabulate
		dev-python/pip
		dev-python/dbus-python
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
	dev-python/setuptools
"

python_prepare_all() {
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
	systemd_newunit "${FILESDIR}"/ofonoctl.service 'ofonoctl.service'
}
