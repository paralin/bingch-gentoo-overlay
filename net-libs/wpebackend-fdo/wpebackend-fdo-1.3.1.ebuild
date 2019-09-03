# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
CMAKE_MAKEFILE_GENERATOR="ninja"

inherit cmake-utils flag-o-matic virtualx

DESCRIPTION="A WPE backend designed for Linux desktop"
HOMEPAGE="https://github.com/Igalia/WPEBackend-fdo"
SRC_URI="https://github.com/Igalia/WPEBackend-fdo/releases/download/${PV}/${P}.tar.xz"
SLOT="0"

LICENSE="BSD"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~amd64-linux ~x86-linux ~x86-macos"

IUSE="+gles2"

# Tests fail to link for inexplicable reasons
# https://bugs.webkit.org/show_bug.cgi?id=148210
RESTRICT="test"

RDEPEND="
	net-libs/libwpe
	dev-libs/wayland
	gles2? ( media-libs/mesa[gles2] )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
