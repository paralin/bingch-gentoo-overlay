# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit eutils autotools git-r3
DESCRIPTION="The intelligent predictive text entry system"
HOMEPAGE="http://presage.sourceforge.net"
EGIT_REPO_URI="https://git.code.sf.net/p/presage/presage"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~arm ~x86"
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

PATCHES="${FILESDIR}/${PN}-0.9.1-automagic.patch"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable doc documentation) \
		$(use_enable gtk gpresagemate) \
		$(use_enable gtk gprompter) \
		$(use_enable examples curses) \
		$(use_enable python) \
		$(use_enable python python-binding) \
		$(use_enable sqlite) \
		$(use_enable test)
}
