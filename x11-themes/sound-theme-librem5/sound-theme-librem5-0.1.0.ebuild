# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Sound theme for the Librem 5"
HOMEPAGE="https://source.puri.sm/Librem5/sound-theme-librem5"
SRC_URI="https://source.puri.sm/Librem5/sound-theme-librem5/-/archive/v${PV}/${PN}-v${PV}.tar.gz"

LICENSE="GPL-2 LGPL-2 CC-BY-3.0 CC-BY-SA-2.0"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~mips ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

RDEPEND=""
DEPEND="sys-devel/gettext
	dev-libs/glib:2
	>=dev-util/intltool-0.40"

S=${WORKDIR}/${PN}-v${PV}

src_install() {
	insinto /usr/share/sounds/
	doins -r librem5
}
