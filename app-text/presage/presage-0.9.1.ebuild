# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit eutils autotools flag-o-matic
DESCRIPTION="The intelligent predictive text entry system"
HOMEPAGE="http://presage.sourceforge.io"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~arm ~x86"

SRC_URI="https://download.sourceforge.net/project/presage/presage/${PV}/${P}.tar.gz"

if [[ ${PV} = 9999 ]]; then
	inherit git-r3
	SRC_URI=""
    KEYWORDS=""
	EGIT_REPO_URI="https://git.code.sf.net/p/presage/presage"
fi


IUSE="examples doc gtk python +sqlite test"

RDEPEND="
	examples? ( sys-libs/ncurses )
	gtk? ( x11-libs/gtk+ )
	python? ( dev-lang/python dev-python/dbus-python )
	sqlite? ( dev-db/sqlite )
	app-text/dos2unix
"

DEPEND="${COMMON_DEPEND}
	doc? ( app-doc/doxygen )
	dev-lang/swig
	test? ( dev-util/cppunit )
	sys-apps/help2man
"

PATCHES="${FILESDIR}/${PN}-0.9.1-automagic.patch
	${FILESDIR}/${PN}-gcc6.patch"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	# code is not C++17 ready
	append-cxxflags -std=c++14
	econf \
		$(use_enable doc documentation) \
		$(use_enable gtk gprompter) \
		$(use_enable gtk gpresagemate) \
		$(use_enable examples curses) \
		$(use_enable python) \
		$(use_enable python python-binding) \
		$(use_enable sqlite) \
		$(use_enable test) \
		--disable-gprompter
}
