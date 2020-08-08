# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="vfs0090 driver using libfprint-TOD"
HOMEPAGE="https://gitlab.com/bingch/libfprint-tod-vfs0090.git"
if [[ ${PV} == 9999 ]]; then
    inherit git-r3
    EGIT_REPO_URI="https://gitlab.com/bingch/libfprint-tod-vfs0090.git"
else
	SRC_URI=""
fi

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-auth/libfprint-9999"
RDEPEND="${DEPEND}"
BDEPEND=""
