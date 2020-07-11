# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit pam cmake

DESCRIPTION="A tool to test PAM applications and PAM modules"
HOMEPAGE="https://cwrap.org/pam_wrapper.html"
SRC_URI="https://ftp.samba.org/pub/cwrap/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~arm64 ~ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="
	sys-libs/pam"
DEPEND="${RDEPEND}"

#PATCHES=( "${FILESDIR}"/${P}-headers.patch )

#src_install() {
#	dopammod src/lib${PN}.so
#	newbin src/pamtest pamtest.fprint
#	dobin src/pam_fprint_enroll
#	einstalldocs
#}
