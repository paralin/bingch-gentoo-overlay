# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Example libpfprint driver using libfprint-TOD"
HOMEPAGE="https://gitlab.freedesktop.org/3v1n0/libfprint-tod-example-driver.git"
if [[ ${PV} == 9999 ]]; then
    inherit git-r3
    EGIT_REPO_URI="https://gitlab.freedesktop.org/3v1n0/libfprint-tod-example-driver.git"
else
	SRC_URI=""
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-auth/libfprint"
RDEPEND="${DEPEND}"
BDEPEND=""
