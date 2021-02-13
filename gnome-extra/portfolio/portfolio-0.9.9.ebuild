# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit meson gnome2-utils python-single-r1 xdg

DESCRIPTION="A minimalist file manager for those who want to use Linux mobile devices"
HOMEPAGE="https://github.com/tchx84/Portfolio"
SRC_URI="https://github.com/tchx84/Portfolio/archive/v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	gui-libs/libhandy
	x11-libs/gtk+
	"

DEPEND="${RDEPEND}"
BDEPEND=""

S=${WORKDIR}/Portfolio-${PV}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}

