# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
CMAKE_MAKEFILE_GENERATOR="ninja"

inherit cmake-utils flag-o-matic virtualx

DESCRIPTION="General-purpose library for the WPE-flavored port of WebKit"
HOMEPAGE="https://github.com/WebPlatformForEmbedded/libwpe"
SRC_URI="https://www.webkitgtk.org/releases/${P}.tar.xz"
SLOT="0"

LICENSE="BSD"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~amd64-linux ~x86-linux ~x86-macos"

IUSE="+gles2"

# Tests fail to link for inexplicable reasons
# https://bugs.webkit.org/show_bug.cgi?id=148210
RESTRICT="test"

RDEPEND="
	>=x11-libs/cairo-1.16.0
	x11-libs/libxkbcommon
	gles2? ( media-libs/mesa[gles2] )
"

# paxctl needed for bug #407085
# Need real bison, not yacc
DEPEND="${RDEPEND}
	virtual/pkgconfig"
