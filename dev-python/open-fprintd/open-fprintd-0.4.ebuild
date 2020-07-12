# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

#inherit python-r1
DISTUTILS_USE_SETUPTOOLS=no

inherit distutils-r1



DESCRIPTION="fprintd replacement allows you to have your own backend as a standalone service"
HOMEPAGE="https://github.com/uunicorn/open-fprintd"
SRC_URI="http://ppa.launchpad.net/uunicorn/open-fprintd/ubuntu/pool/main/o/open-fprintd/${PN}_${PV}~ppa1.tar.xz"

LICENSE="LGPL-2.1+"
SLOT="3"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	sys-auth/fprintd[-daemon]
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"
S="${WORKDIR}/${PN}"

src_configure() {
	python_foreach_impl configuring
}

python_prepare_all() {
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
}
