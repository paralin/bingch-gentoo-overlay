# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

#inherit python-r1
DISTUTILS_USE_SETUPTOOLS=no

inherit distutils-r1

DESCRIPTION="Validity fingerprint sensor library"
HOMEPAGE="https://github.com/uunicorn/python-validity"
SRC_URI="http://ppa.launchpad.net/uunicorn/open-fprintd/ubuntu/pool/main/p/python-validity/${PN}_${PV}~ppa2.tar.xz"

LICENSE="LGPL-2.1+"
SLOT="3"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"
S="${WORKDIR}/${PN}"

python_prepare_all() {
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
}
