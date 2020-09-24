# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="AT commands as input are sent to modem and responses given as output"
HOMEPAGE="http://atinout.sourceforge.net/index.html"
SRC_URI="https://netcologne.dl.sourceforge.net/project/atinout/v${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=("${FILESDIR}/0001-make-gcc-happy-by-adding-fallthrough-comment.patch"
		"${FILESDIR}/0002-do-not-rely-on-CR-in-modem-output.patch"
)
